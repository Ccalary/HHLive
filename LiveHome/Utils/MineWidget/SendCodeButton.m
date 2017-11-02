//
//  SendCodeButton.m
//  LiveHome
//
//  Created by chh on 2017/10/30.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "SendCodeButton.h"

@interface SendCodeButton()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) int totalSeconds;
@property (nonatomic, assign) int num;
@end

@implementation SendCodeButton
- (instancetype)initWithTitle:(NSString *)title seconds:(int)seconds{
    if (self = [super init]){
        self.title = title;
        self.totalSeconds = seconds;
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title seconds:(int)seconds{
    if (self = [super initWithFrame:frame]){
        self.title = title;
        self.totalSeconds = seconds;
        [self setUp];
    }
    return self;
}

- (void)setUp{
    [self setTitle:self.title forState:UIControlStateNormal];
    self.titleLabel.font = FONT_SYSTEM(15);
    [self setTitleColor:[UIColor fontColorBlack] forState:UIControlStateNormal];
    [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonAction:(UIButton *)button{
    [self destroyTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    self.num = self.totalSeconds;
    //代理方法
    if ([self.delegate respondsToSelector:@selector(sendCodeButtonClick)]){
        [self.delegate sendCodeButtonClick];
    }
}

//倒计时
- (void)countdown{
    self.num --;
    [self setTitle:[NSString stringWithFormat:@"%ds",self.num] forState:UIControlStateNormal];
    if (self.num <= 0){
        [self destroyTimer];
        [self setTitle:self.title forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
    }else {
        self.userInteractionEnabled = NO;
    }
}

//销毁计时器
- (void)destroyTimer{
    [_timer invalidate];
    _timer = nil;
}
@end
