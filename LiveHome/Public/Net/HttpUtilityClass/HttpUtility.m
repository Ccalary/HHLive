//
//  HttpUtility.m
//  JzyTest
//
//  Created by 姜志远 on 2017/6/2.
//  Copyright © 2017年 姜志远. All rights reserved.
//



#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


#import "HttpUtility.h"

#import "NSString+Extend.h"
#import "NSDate+Format.h"
#import "NSObject+Extend.h"

#import "ApiResultData.h"

#import "AFNetworking.h"
#import "FunUtil.h"

typedef NS_ENUM(NSInteger, NSPUIImageType)
{
    NSPUIImageType_JPEG,
    NSPUIImageType_PNG,
    NSPUIImageType_Unknown
};


@implementation HttpUtility
+ (HttpUtility *)sharedInstance {
    static HttpUtility * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[HttpUtility alloc] init];
    });
    
    return _sharedInstance;
}

#pragma mark - 签名等辅助方法

/**
 数据格式

 @param imageData 格式
 @return 格式
 */
static inline NSPUIImageType NSPUIImageTypeFromData(NSData *imageData)
{
    if (imageData.length > 4) {
        const unsigned char * bytes = [imageData bytes];
        
        if (bytes[0] == 0xff &&
            bytes[1] == 0xd8 &&
            bytes[2] == 0xff)
        {
            return NSPUIImageType_JPEG;
        }
        
        if (bytes[0] == 0x89 &&
            bytes[1] == 0x50 &&
            bytes[2] == 0x4e &&
            bytes[3] == 0x47)
        {
            return NSPUIImageType_PNG;
        }
    }
    
    return NSPUIImageType_Unknown;
}
/**
 获得参数的签名

 @param dict 待签名的参数
 @param date 时间
 @return 签名
 */
- (NSString *)getParamsSignWithDictionary:(NSDictionary *)dict withTime:(NSDate *)date
{
    if(dict == nil || dict.allKeys.count == 0){
        return @"";
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:dict];
    [params setObject:[date toDateTimeUTCFormat] forKey:@"_time"];
    NSString *key = [NSString stringWithFormat:@"wkSign=%@",[date toDateTimeUTCFormat]];
    NSString * resultString = key;
    NSMutableArray *stringArray = [NSMutableArray arrayWithArray:params.allKeys];
    [stringArray sortUsingComparator: ^NSComparisonResult (NSString *str1, NSString *str2) {
        NSString *n1 = [str1 lowercaseString];
        NSString *n2 = [str2 lowercaseString];
        return [n1 compare:n2];
    }];
    for(NSString * key in stringArray){
        NSString *value = [params valueForKey:key];
        
        NSString *s = [NSString stringWithFormat:@"%@",value];
        
        if([FunUtil isBlankString:s] == YES)
        {
            continue;
        }
        resultString = [resultString stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",[key lowercaseString],[params valueForKey:key]]];
    }
    
    resultString = [resultString stringByAppendingString:[NSString stringWithFormat:@"&%@",key]];
    //NSLog(@"_sign = %@",resultString);
    return [resultString md5];
}

/**
 获取加密后的参数对

 @param parameters 待加密的参数
 @param now 时间
 @return 加密后的参数对
 */
-(NSDictionary *)getEncryptParams:(NSDictionary *)parameters withTime:(NSDate *)now
{
    if(parameters == nil || parameters.allKeys.count == 0)
    {
        return nil;
    }
    //NSLog(@"时间戳: %@",[now toDateTimeUTCFormat]);
    NSString *unencrypt = [NSString stringWithFormat:@"%@=%@+%@+%@",
                           @"WKFindUpload",
                           @"ios",
                           [@"ios" md5],
                           [now toDateTimeUTCFormat]];
    //NSLog(@"未md5前的密匙: %@",unencrypt);
    NSString *upkey = [unencrypt md5];
    //NSLog(@"加密key: %@",upkey);
    NSString * p = [parameters jsonSerialize];
//    NSLog(@"加密内容: %@",p);
    p = [p AES256EncryptWithKey:upkey];
//    NSLog(@"加密后: %@",p);
    return @{@"upload":p};
}

-(NSDictionary *)getSignParams:(NSDictionary *)parameters withTime:(NSDate *)now
{
    DLog(@"param:%@",parameters);
    if(parameters == nil || parameters.allKeys.count == 0)
    {
        return nil;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *sign = [self getParamsSignWithDictionary:parameters withTime:now];
    [params setDictionary:parameters];
    [params setValue:sign forKey:@"_sign"];
    
    NSDictionary *p = [params copy];
    
    params = nil;
//    NSLog(@"upload = %@",p);
    return p;
}

#pragma mark - afn GET

-(void) GET:(NSString *)URLString
 loadingText:(NSString *)text
 parameters:(nullable NSDictionary*)parameters
   progress:(nullable void (^)(float))downloadProgress
    success:(nullable void (^)(ApiResultData* _Nullable))success
    failure:(nullable void (^)(ApiResultData* _Nullable))failure
{
    if (text.length > 0){
        [LCProgressHUD showLoading:text];
    }
    NSDate *now = [NSDate date];
    NSDictionary *params = [self getSignParams:parameters withTime:now];
    params = [self getEncryptParams:params withTime:now];
    [self dataTaskWithHTTPMethod:wk_GET loadingText:text URLString:URLString parameters:params date:now progress:downloadProgress success:success failure:failure];
}



#pragma mark - POST

-(void) POST:(NSString *)URLString
 loadingText:(NSString *)text
  parameters:(nullable NSDictionary*)parameters
    progress:(nullable void (^)(float))uploadProgress
     success:(nullable void (^)(ApiResultData* _Nullable))success
     failure:(nullable void (^)(ApiResultData* _Nullable))failure
{
    if (text.length > 0){
        [LCProgressHUD showLoading:text];
    }
    
    NSDate *now = [NSDate date];
    NSDictionary *params = [self getSignParams:parameters withTime:now];
    params = [self getEncryptParams:params withTime:now];
    [self dataTaskWithHTTPMethod:wk_POST loadingText:text URLString:URLString parameters:params date:now progress:uploadProgress success:success failure:failure];
}

#pragma mark - uploadfile

-(NSURLSessionDataTask * _Nullable)uploadImage:(NSString * _Nullable)URLString
                     parameters:(nullable NSDictionary*)parameters
                          files:(nullable NSArray*)files
                       progress:(nullable void (^)(float))progress
                        success:(nullable void (^)(ApiResultData* _Nullable))success
                        failure:(nullable void (^)(ApiResultData* _Nullable))failure
{
    NSDate *now = [NSDate date];
    NSDictionary *params = [self getSignParams:parameters withTime:now];
    params = [self getEncryptParams:params withTime:now];
    AFHTTPSessionManager *manager = [self mgrWithTime:now];
    
    id apiprogress = ^(NSProgress * _Nonnull dP) {
        //NSLog(@"%lf",1.0 * dP.completedUnitCount / dP.totalUnitCount);
        if(progress)
        {
            progress(1.0 * dP.completedUnitCount / dP.totalUnitCount);
        }
    };
    id apisuccess=^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if([responseObject isKindOfClass:[NSData class]])
        {
            NSString *str= [[NSMutableString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            responseObject = str;
        }
        
        //NSLog(@"调用返回：%@",responseObject);
        
        // 获取 header  中的time的方法：
        NSString *time;
        BOOL encrypt = NO;
        
        NSDate *date;
        if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
            time = [r allHeaderFields][@"wk-time"];
            NSString *e = [r allHeaderFields][@"wk-e"];
            if(e == nil || [FunUtil isNull:e] || [e isEqualToString: @"0"])
            {
                encrypt = NO;
            }
            else
            {
                encrypt = YES;
            }
        }
        if(time)
        {
            date = [[NSDate alloc] initWithTimeIntervalSince1970:[time integerValue]/1000];
            //NSLog(@"时间戳: %@",[date toDateTimeFormat]);
        }
        
        
        if(responseObject)
        {
            if(encrypt)
            {
                //NSLog(@"解密内容: %@",responseObject);
                NSString *resultkey = [NSString stringWithFormat:@"%@=%@+%@+%@",@"WKFindReturn",@"ios",[@"ios" md5],[date toDateTimeFormat]];
                //NSLog(@"解密key: %@，  %@",resultkey,[resultkey md5]);
                //NSLog(@"解密key: %@",resultkey);
                resultkey = [resultkey md5];
                //NSLog(@"解密key: %@",resultkey);
                NSString *r = [responseObject AES256DecryptWithKey:resultkey];
                //NSLog(@"解密结果：%@",r);
                responseObject = [r jsonDeserialize];
            }
            else
            {
                responseObject = [responseObject jsonDeserialize];
            }
            
            ApiResultData *data = [ApiResultData new];
            data.code = [[responseObject objectForKey:@"code"] intValue];
            data.message = [responseObject objectForKey:@"message"];
            data.data = [responseObject objectForKey:@"data"];
            
            if([FunUtil isNull:data.data])
            {
                data.data = nil;
            }
            
            if(data.code == 200)
            {
                if(success)
                {
                    success(data);
                }
            }
            else
            {
                if(failure)
                {
                    failure(data);
                }
            }
        }
    };
    id apifailure = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"调用失败：%@",error);
        
        ApiResultData *data = [ApiResultData new];
        data.code = (int)wk_NetworkFail;
        data.message = error.description;
        if(failure)
        {
            failure(data);
        }
    };
    
    NSURLSessionDataTask * dataTask = [manager POST:URLString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if(files == nil || files.count==0) return;
        for (int i = 0; i < files.count; i++) {
            id d = files[i];
            
            NSData *data;
            NSString *name = @"";
            NSString *filename = @"";
            NSString *mimetype = @"";
            NSPUIImageType type = NSPUIImageType_Unknown;
            
            if([d isKindOfClass:[NSData class]])
            {
                data = d;
                type = NSPUIImageTypeFromData(data);
            }
            else if ([d isKindOfClass:[UIImage class]])
            {
                data = UIImagePNGRepresentation(d);
                if(data != nil)
                {
                    type= NSPUIImageType_PNG;
                }
                else
                {
                    data = UIImageJPEGRepresentation(d, 1.0);
                    if(data)
                    {
                        type = NSPUIImageType_JPEG;
                    }
                    else
                    {
                        type = NSPUIImageType_Unknown;
                    }
                }
            }
            if(type == NSPUIImageType_JPEG)
            {
                name = [NSString stringWithFormat:@"jpgImage_%d",i];
                filename = [name stringByAppendingString:@".jpg"];
                mimetype = @"image/jpg";
            }
            else if(type == NSPUIImageType_PNG)
            {
                name = [NSString stringWithFormat:@"pngImage_%d",i];
                filename = [name stringByAppendingString:@".png"];
                mimetype = @"image/png";
            }
            else
            {
                continue;
            }
            [formData appendPartWithFileData:data name:name fileName:filename mimeType:mimetype];
        }
        
        
    } progress:apiprogress success:apisuccess failure:apifailure];
    
    
    [dataTask resume];
    
    return dataTask;
}

#pragma mark - get/post总控制

- (AFHTTPSessionManager *) mgrWithTime:(NSDate *)now
{
    
    //AFHTTPSessionManager *manager = [[AFHTTPSessionManager manager] initWithBaseURL:[NSURL URLWithString:@"http://192.168.0.224:7007/"]];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager manager] initWithBaseURL:[NSURL URLWithString:@"https://findapi.o2o.com.cn:2443/"]];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 1 * 60.f;
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString* secretAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    //NSLog(@"secretAgent:%@",secretAgent);
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString*  useragent = [NSString stringWithFormat:@"%@ livehome/%@",secretAgent,version];
    [manager.requestSerializer setValue:useragent forHTTPHeaderField:@"User-Agent"];
    
    long time = [now toLongUTC];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",time] forHTTPHeaderField:@"wk-time"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"wk-e"];
     NSString *diviceID = [[UIDevice currentDevice].identifierForVendor UUIDString];
    [manager.requestSerializer setValue:diviceID forHTTPHeaderField:@"wk-user-device"];
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"Cookie"];
    
    NSString *auth = [UserHelper getMemberAuth];
    NSString *userId = [UserHelper getMemberId];
    
    if(auth && userId)
    {
        [manager.requestSerializer setValue:userId forHTTPHeaderField:@"wk-user-id"];
        [manager.requestSerializer setValue:auth forHTTPHeaderField:@"wk-user-auth"];
    }
    return manager;
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(APIMethod)method
                                     loadingText:(NSString *)text
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                            date:(NSDate *)now
                                        progress:(nullable void (^)(float))progress
                                         success:(nullable void (^)(ApiResultData* _Nullable))success
                                         failure:(nullable void (^)(ApiResultData* _Nullable))failure
{
    AFHTTPSessionManager *manager = [self mgrWithTime:now];
    NSURLSessionDataTask *dataTask;
    
    id apiprogress = ^(NSProgress * _Nonnull dP) {
        //NSLog(@"%lf",1.0 * dP.completedUnitCount / dP.totalUnitCount);
        if(progress)
        {
            progress(1.0 * dP.completedUnitCount / dP.totalUnitCount);
        }
    };
    id apisuccess=^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if([responseObject isKindOfClass:[NSData class]])
        {
            NSString *str= [[NSMutableString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            responseObject = str;
        }
        
        //NSLog(@"调用返回：%@",responseObject);
        
        // 获取 header  中的time的方法：
        NSString *time;
        BOOL encrypt = NO;
        
        NSDate *date;
        if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
            time = [r allHeaderFields][@"wk-time"];
            NSString *e = [r allHeaderFields][@"wk-e"];
            if(e == nil || [FunUtil isNull:e] || [e isEqualToString: @"0"])
            {
                encrypt = NO;
            }
            else
            {
                encrypt = YES;
            }
        }
        if(time)
        {
            date = [[NSDate alloc] initWithTimeIntervalSince1970:[time integerValue]/1000];
            //NSLog(@"时间戳: %@",[date toDateTimeFormat]);
        }
        
        
        if(responseObject)
        {
            if(encrypt)
            {
                //NSLog(@"解密内容: %@",responseObject);
                NSString *resultkey = [NSString stringWithFormat:@"%@=%@+%@+%@",@"WKFindReturn",@"ios",[@"ios" md5],[date toDateTimeFormat]];
                //NSLog(@"解密key: %@，  %@",resultkey,[resultkey md5]);
                //NSLog(@"解密key: %@",resultkey);
                resultkey = [resultkey md5];
                //NSLog(@"解密key: %@",resultkey);
                NSString *r = [responseObject AES256DecryptWithKey:resultkey];
//                NSLog(@"--------------------------------------------------------------------------------------------");
//                NSLog(@"解密结果：%@",[r stringByReplacingOccurrencesOfString:@"\0" withString:@""]);
//                NSLog(@"--------------------------------------------------------------------------------------------");
                responseObject = [r jsonDeserialize];
            }
            else
            {
                responseObject = [responseObject jsonDeserialize];
            }
            
            ApiResultData *data = [ApiResultData new];
            data.code = [[responseObject objectForKey:@"code"] intValue];
            data.message = [responseObject objectForKey:@"message"];
            data.data = [responseObject objectForKey:@"data"];
            
            NSLog(@"返回结果:%@", responseObject);
            //隐藏HUD
            [LCProgressHUD hide];
            if([FunUtil isNull:data.data])
            {
                data.data = nil;
            }
            
            if(data.code == 200)
            {
                if(success)
                {
                    success(data);
                }
            }
            else
            {
                if(failure)
                {
                    //增加显示
                    if(data.code == 300){
                        
                        if (text.length > 0) {
                             [LCProgressHUD showFailure:data.message];
                        }else {
                             [LCProgressHUD showKeyWindowFailure:data.message];
                        }
    
                    }else {
                        
                        if (text.length > 0) {
                           [LCProgressHUD showFailure:@"请求失败，请稍后再试"];
                        }else {
                            [LCProgressHUD showKeyWindowFailure:@"请求失败，请稍后再试"];
                        }
                    }
                    failure(data);
                }
            }
        }
    };
    id apifailure = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"调用失败：%@",error);
        
        ApiResultData *data = [ApiResultData new];
        data.code = (int)wk_NetworkFail;
        data.message = error.description;
        if(failure)
        {
            failure(data);
        }
    };
    
    if(method == wk_GET)
    {
        dataTask = [manager GET:URLString parameters:parameters progress:apiprogress success:apisuccess failure:apifailure];

    }
    else
    {
        dataTask = [manager POST:URLString parameters:parameters progress:apiprogress success:apisuccess failure:apifailure];
    }
    
    
    [dataTask resume];
    
    return dataTask;
}



@end
