//
//  OldVideosVC.m
//  LiveHome
//
//  Created by chh on 2017/10/28.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "OldVideosVC.h"
#import "OldVideosCollectionViewCell.h"
#import "FBKVOController.h"

@interface OldVideosVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *mCollectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) FBKVOController *kvoController;
@property (nonatomic, strong) UIView *holdView;
@end

@implementation OldVideosVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initDefaultView];
    [self initFBKVO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)initView{
    self.view.backgroundColor = [UIColor bgColorMain];
    self.navigationItem.title = @"历史";
    
    CGFloat ItemWidth = (ScreenWidth - 15*UIRate)/2.0;
    CGFloat ItemHeight = 153*UIRate;
    UICollectionViewFlowLayout * aLayOut = [[UICollectionViewFlowLayout alloc]init];
    aLayOut.itemSize = CGSizeMake(ItemWidth, ItemHeight);
    aLayOut.minimumLineSpacing = 3*UIRate;
    aLayOut.minimumInteritemSpacing = 4*UIRate;
    aLayOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    _mCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:aLayOut];
    [_mCollectionView registerClass:[OldVideosCollectionViewCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
    _mCollectionView.delegate = self;
    _mCollectionView.dataSource = self;
    _mCollectionView.backgroundColor = [UIColor bgColorMain];
    [self.view addSubview:_mCollectionView];
    [_mCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5*UIRate);
        make.right.offset(-5*UIRate);
        make.top.offset(10*UIRate);
        make.bottom.equalTo(self.view);
    }];
    
    __weak typeof (self) weakSelf = self;
    _mCollectionView.mj_header = [HHRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    _mCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
  
    }];
}

- (void)initDefaultView{
    
    _holdView = [[UIView alloc] init];
    _holdView.backgroundColor = [UIColor clearColor];
    _holdView.hidden = YES;
    [self.view addSubview:_holdView];
    
    UIImageView *defaultImageView = [[UIImageView alloc] init];
    defaultImageView.image = [UIImage imageNamed:@"camera_150"];
    [_holdView addSubview:defaultImageView];
    
    UILabel *stringLabel = [[UILabel alloc] init];
    stringLabel.numberOfLines = 0;
    stringLabel.font = FONT_SYSTEM(15);
  
    stringLabel.textColor = [UIColor fontColorLightGray];
    [_holdView addSubview:stringLabel];
    
    NSString *textString = @"您还没有直播历史\n请开始直播吧！";
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:textString];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8]; //调整行间距
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributeStr length])];
    stringLabel.attributedText = attributeStr;
    stringLabel.textAlignment = NSTextAlignmentCenter;
    
    [_holdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [defaultImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_holdView);
        make.top.offset(135*UIRate);
        make.width.mas_equalTo(150*UIRate);
        make.height.mas_equalTo(150*UIRate);
    }];
    [stringLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_holdView);
        make.top.equalTo(defaultImageView.mas_bottom).offset(35*UIRate);
    }];
}

- (void)initFBKVO{
    //KVO
    __weak typeof (self) weakSelf = self;
    self.kvoController = [FBKVOController controllerWithObserver:self];
    [self.kvoController observe:self.mCollectionView keyPath:@"contentSize" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        
        CGFloat height =  weakSelf.mCollectionView.contentSize.height;
        _holdView.hidden = (height > 20) ? YES : NO;
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arc4random()%5;
}

//cell的记载
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OldVideosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    return cell;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}
@end
