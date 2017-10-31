//
//  Connect.h
//  HHFramework
//
//  Created by chh on 2017/7/31.
//  Copyright © 2017年 chh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Connect : NSObject
+ (Connect *)sharedInstance;
-(void)doGetNetworkWithUrl:(NSString*)url
                parameters:(id)parameters
                   success:(void (^)(NSURLSessionDataTask *operation, NSDictionary *responseDic))success
                   failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

-(void)doPostNetworkWithUrl:(NSString*)url
                 parameters:(id)parameters success:(void (^)(id responseObject))success
       successBackfailError:(void (^)(id responseObject))successBackfailError
                    failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

-(void)doImagePostNetworkWithUrl:(NSString*)url
                      parameters:(id)parameters
                      imageArray:(NSArray *)array
                          isNone:(BOOL)isNone
                         success:(void (^)(id responseObject))success
                successBackfailError:(void (^)(id responseObject))successBackfailError
                         failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
@end
