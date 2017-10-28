//
//  SSPageViewController.m
//  chizhaonline
//
//  Created by 李飞恒 on 2017/9/1.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "SSPageViewController.h"

@interface SSPageViewController ()

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray *controllersArr;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) UICollectionView *titleCollectionView;

@end

@implementation SSPageViewController
#define kCollectionViewWidth (kWidth-16)

- (void)addViewControllers:(NSArray <UIViewController *>*)controllers
{
    self.controllersArr = controllers;
    [controllers enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL * stop) {
        [self.titleArray addObject:obj.title];
    }];
    [self.titleCollectionView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.controllersArr = [NSMutableArray array];
    self.titleArray = [NSMutableArray array];
    
    [self createCollectionView];
    [self createPageViewController];
}

// 创建标题collectionview
- (void)createCollectionView
{
#warning 这里在使用的时候需要修改一下
    UICollectionViewFlowLayout *lay = [[UICollectionViewFlowLayout alloc] init];
    lay.itemSize = CGSizeMake((kWidth-44-44-(3*8))/self.controllersArr.count, 44);
    lay.minimumLineSpacing = 0;
    lay.minimumInteritemSpacing = 0;
    lay.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.titleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kCollectionViewWidth, 44) collectionViewLayout:lay];
    self.titleCollectionView.showsHorizontalScrollIndicator = NO;
    self.titleCollectionView.backgroundColor = [UIColor whiteColor];
    self.titleCollectionView.delegate = self;
    self.titleCollectionView.dataSource = self;
    [self.titleCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"titleReuse"];
    
    self.navigationItem.titleView = self.titleCollectionView;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [self.controllersArr objectAtIndex:indexPath.row];
    if (indexPath.row > ld_currentIndex) {
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        }];
    } else {
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
        }];
    }
    ld_currentIndex = indexPath.row;
    NSIndexPath *path = [NSIndexPath indexPathForRow:ld_currentIndex inSection:0];
    [self.titleCollectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.titleCollectionView reloadData];
}

// 创建pageViewController
- (void)createPageViewController
{
    NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:0] forKey:UIPageViewControllerOptionInterPageSpacingKey];
    _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
}

// 展示上一页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self.controllersArr indexOfObject:viewController];
    if (index == 0 || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self.controllersArr objectAtIndex:index];
}

// 展示下一页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.controllersArr indexOfObject:viewController];
    if (index == self.controllersArr.count - 1 || (index == NSNotFound)) {
        return nil;
    }
    index++;
    return [self.controllersArr objectAtIndex:index];
}

// 将要滑动切换的时候
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    UIViewController *nextVC = [pendingViewControllers firstObject];
    NSInteger index = [self.controllersArr indexOfObject:nextVC];
    ld_currentIndex = index;
}

// 滑动结束后
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:ld_currentIndex inSection:0];
        [self.titleCollectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        [self.titleCollectionView reloadData];
        NSLog(@">>>>>>>>> %ld", (long)ld_currentIndex);
    }
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    NSAssert(self.controllersArr.count > 0, @"必须至少有一个childViewCpntroller");
    NSAssert(self.titleArray.count == self.controllersArr.count, @"childViewController的数不等于titleArray的计数");
    
    UIViewController *vc = [self.controllersArr objectAtIndex:ld_currentIndex];
    [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
