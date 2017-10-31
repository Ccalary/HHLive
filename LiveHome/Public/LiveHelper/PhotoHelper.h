//
//  PhotoHelper.h
//  LiveHome
//
//  Created by chh on 2017/10/31.
//  Copyright © 2017年 chh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PhotoHelperBlock)(UIImage *image);

@interface PhotoHelper : NSObject

@property (nonatomic, copy) PhotoHelperBlock block;

+ (PhotoHelper *)sharedInstance;

- (void)addPhotoWithController:(UIViewController *)controller;
@end
