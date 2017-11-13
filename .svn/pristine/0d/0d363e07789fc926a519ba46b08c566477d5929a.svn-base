//
//  HttpUtility.h
//  JzyTest
//
//  Created by 姜志远 on 2017/6/2.
//  Copyright © 2017年 姜志远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserHelper.h"

@class ApiResultData;

typedef enum{
    wk_GET,
    wk_POST
} APIMethod;

@interface HttpUtility : NSObject
+ (HttpUtility *_Nullable)sharedInstance;

-(void) GET:(NSString *_Nonnull)URLString
loadingText:(nullable NSString *)text
 parameters:(nullable NSDictionary*)parameters
   progress:(nullable void (^)(float p))downloadProgress
    success:(nullable void (^)(ApiResultData* _Nullable data))success
    failure:(nullable void (^)(ApiResultData* _Nullable data))failure;


-(void) POST:(NSString *_Nonnull)URLString
 loadingText:(nullable NSString *)text
  parameters:(nullable NSDictionary*)parameters
    progress:(nullable void (^)(float))uploadProgress
     success:(nullable void (^)(ApiResultData* _Nullable))success
     failure:(nullable void (^)(ApiResultData* _Nullable))failure;

-(NSURLSessionDataTask *_Nullable)uploadImage:(NSString *_Nullable)URLString
                          parameters:(nullable NSDictionary*)parameters
                               files:(nullable NSArray*)files
                            progress:(nullable void (^)(float))progress
                             success:(nullable void (^)(ApiResultData* _Nullable data))success
                             failure:(nullable void (^)(ApiResultData* _Nullable data))failure;
@end
