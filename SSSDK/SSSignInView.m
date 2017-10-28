//
//  SSSignInView.m
//  CZOL
//
//  Created by 李飞恒 on 2017/10/17.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "SSSignInView.h"

@interface SSSignInView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIImageView *imagView;

@property (nonatomic, strong) UICollectionView *collectionView;

@end
@implementation SSSignInView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        
        [self addSubview:self.centreView];
        [self addSubview:self.imagView];
        [self.centreView addSubview:self.titleLabel];
        
        [self.centreView addSubview:self.collectionView];
        [self.centreView addSubview:self.signIn];
    }
    return self;
}

- (UIView *)centreView
{
    if (!_centreView) {
        _centreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*0.7, [UIScreen mainScreen].bounds.size.width)];
        _centreView.center = self.center;
        _centreView.backgroundColor = [UIColor whiteColor];
        _centreView.exclusiveTouch = YES;
        _centreView.multipleTouchEnabled = YES;
    }
    return _centreView;
}

- (UIImageView *)imagView
{
    if (!_imagView) {
        _imagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Content_CheckIn"]];
        [_imagView setFrame:CGRectMake(0, self.centreView.minY-kPx(self.width*0.3), self.width, self.width*0.3)];
        _imagView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imagView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPx(kPx(self.centreView.bounds.size.width)), 0, kPx(self.centreView.bounds.size.width), 58)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = self.centreView.backgroundColor;
        _titleLabel.layer.cornerRadius = 8;
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _titleLabel.text = kLocalized(@"已连续签到了0天");
        
        UIView *link = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.centreView.width, 0.5)];
        link.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        link.center = _titleLabel.center;
        [self.centreView addSubview:link];
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = [NSString stringWithFormat:@"%@ %@天",NSLocalizedString(@"已连续签到了", nil),title];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(self.centreView.width*0.3-8, self.centreView.width*0.3-8);
        flowLayout.minimumInteritemSpacing = 8;
        flowLayout.minimumLineSpacing = 8;
        flowLayout.scrollDirection = YES;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.titleLabel.height, self.centreView.width, self.centreView.height-self.titleLabel.height-self.signIn.height) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = kColorClear;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"SingInViewCell"];
    }
    return _collectionView;
}


- (UIButton *)signIn
{
    if (!_signIn) {
        _signIn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.centreView.bounds.size.height-44, self.centreView.bounds.size.width, 44)];
        [_signIn setBackgroundColor:kThemeTitleColor];
        [_signIn setTitle:NSLocalizedString(@"立即签到", nil) forState:(UIControlStateNormal)];
    }
    return _signIn;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SingInViewCell" forIndexPath:indexPath];
    cell.backgroundColor = kThemeTitleColor;
    cell.contentView.layer.cornerRadius = 3;
    cell.layer.cornerRadius = 3;
    cell.clipsToBounds = YES;
    cell.contentView.clipsToBounds = YES;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:cell.bounds];
    titleLabel.text = [NSString stringWithFormat:@"第%lu天\n\n%lu个\n经验值",indexPath.row+1,20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 4;
    titleLabel.font = [UIFont systemFontOfSize:12];
    [cell addSubview:titleLabel];
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8, 8, 0, 8);
}









- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self.window setWindowLevel:UIWindowLevelNormal];
    [self setHidden:NO];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self setHidden:YES];
    
    [self dismissView];
}

- (void)dismissView
{
    
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

@end
