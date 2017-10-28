//
//  SSPageViewController.h
//  chizhaonline
//
//  Created by 李飞恒 on 2017/9/1.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSViewController.h"

@interface SSPageViewController : SSViewController <UIPageViewControllerDelegate ,UIPageViewControllerDataSource ,UICollectionViewDelegate ,UICollectionViewDataSource>
{
    NSInteger ld_currentIndex;
}

@property (nonatomic, strong) UICollectionViewCell *collectionViewCell;

- (void)addViewControllers:(NSArray <UIViewController *>*)controllers;


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)viewWillLayoutSubviews;

- (UIStatusBarStyle)preferredStatusBarStyle;

@end
