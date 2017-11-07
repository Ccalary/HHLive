//
//  StreamingTopView.h
//  Find
//
//  Created by chh on 2017/10/16.
//  Copyright © 2017年 FindTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StreamingTopView : UIView
@property (nonatomic, strong) UICollectionView *mCollectionView;

- (instancetype)initWithFrame:(CGRect)frame andItemWidth:(CGFloat)itemWidth;
//刷新人气值
//- (void)refreshUIWithPopularNum:(int)num;

@end
