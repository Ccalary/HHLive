//
//  StreamingViewController.h
//  LiveHome
//
//  Created by chh on 2017/11/3.
//  Copyright © 2017年 chh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StreamingViewModel.h"

@interface StreamingViewController : UIViewController
@property (nonatomic, strong) StreamingViewModel *model;

#pragma mark - 会话属性

/*!
 当前会话的会话类型
 */
//@property(nonatomic) RCConversationType conversationType;

/*!
 目标会话ID
 */
@property(nonatomic, strong) NSString *targetId;
@end
