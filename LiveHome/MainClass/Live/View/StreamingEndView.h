//
//  StreamingEndView.h
//  Find
//
//  Created by chh on 2017/8/26.
//  Copyright © 2017年 FindTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^closeBlock)();

@interface StreamingEndView : UIView

@property (nonatomic, copy) closeBlock closeBlock;

- (instancetype)initWithFrame:(CGRect)frame andIsLandscape:(BOOL) isLandscape;
@end
