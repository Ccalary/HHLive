//
//  PopSecurityCodeView.h
//  LiveHome
//
//  Created by chh on 2017/11/2.
//  Copyright © 2017年 chh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^actionBlock)(BOOL isSubmit);

@interface PopSecurityCodeView : UIView
@property (nonatomic, copy) actionBlock block;
@end
