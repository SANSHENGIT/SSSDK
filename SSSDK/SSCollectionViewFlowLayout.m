//
//  SSCollectionViewFlowLayout.m
//  chizhaonline
//
//  Created by 李飞恒 on 2017/9/1.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "SSCollectionViewFlowLayout.h"


@interface SSCollectionViewFlowLayout ()

@end

@implementation SSCollectionViewFlowLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* attributesToReturn = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes* attributes in attributesToReturn) {
        if (nil == attributes.representedElementKind) {
            NSIndexPath* indexPath = attributes.indexPath;
            attributes.frame = [self layoutAttributesForItemAtIndexPath:indexPath].frame;
        }
    }
    return attributesToReturn;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *currentItemAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSInteger itemCount = 0;
    for (int i = 0; i < sectionCount; i++) {
        NSInteger rowCount = [self.collectionView numberOfItemsInSection:i];
        itemCount = itemCount + rowCount;
    }
    // 余数
    NSInteger yushu = itemCount % itemOneLineCount;
    // 行数
    NSInteger hangshu = itemCount / itemOneLineCount;
    
    if (indexPath.item > hangshu * itemOneLineCount - 1) {
        NSInteger index = indexPath.item - (hangshu * itemOneLineCount - 1);
        switch (yushu) {
            case 1: {
                // 最后一行只有一个时候
                // 由于作用域的问题 必须｛｝扩起来
                CGPoint currentItemCenter = [currentItemAttributes center];
                currentItemCenter.x = SCREENW / 2;
                currentItemAttributes.center = currentItemCenter;
            }
                break;
            case 2: {
                // 最后一行只有两个时候
                CGRect currentItemFrame = [currentItemAttributes frame];
                if (index == 1) {
                    // 最后一行第一个
                    // (屏幕宽度 －（两个itemsize的宽度 ＋ 中间间隔）) / 2
                    currentItemFrame.origin.x = SCREENW / 2 - kMinimumInteritemSpacing * Scale / 2 - kItemWidth * Scale;
                } else if (index == 2) {
                    // (屏幕宽度 － （两个itemsize的宽度 ＋ 中间间隔）) / 2 + 中间间隔 ＋ itemsize宽度
                    currentItemFrame.origin.x = SCREENW / 2 + kMinimumInteritemSpacing * Scale / 2;
                }
                currentItemAttributes.frame = currentItemFrame;
            }
                break;
            case 3: {
                CGRect currentItemFrame = [currentItemAttributes frame];
                if (index == 1) {
                    currentItemFrame.origin.x = SCREENW / 2 - kMinimumInteritemSpacing * Scale - kItemWidth * Scale * 1.5;
                } else if (index == 2) {
                    currentItemFrame.origin.x = SCREENW / 2 - kItemWidth * Scale / 2;
                } else if (index == 3) {
                    currentItemFrame.origin.x = SCREENW / 2 + kItemWidth * Scale / 2 + kMinimumInteritemSpacing * Scale;
                }
                currentItemAttributes.frame = currentItemFrame;
            }
                break;
            case 4: {
                CGRect currentItemFrame = [currentItemAttributes frame];
                if (index == 1) {
                    currentItemFrame.origin.x = SCREENW / 2 - kMinimumInteritemSpacing * Scale * 1.5 - kItemWidth * Scale * 2;
                } else if (index == 2) {
                    currentItemFrame.origin.x = SCREENW / 2 - kMinimumInteritemSpacing / 2 - kItemWidth * Scale;
                } else if (index == 3) {
                    currentItemFrame.origin.x = SCREENW / 2 + kMinimumInteritemSpacing * Scale / 2;
                } else if (index == 4) {
                    currentItemFrame.origin.x = SCREENW / 2 + kItemWidth * Scale + kMinimumInteritemSpacing * Scale * 1.5;
                }
                currentItemAttributes.frame = currentItemFrame;
            }
                break;
            default:
                break;
        }
    }
    return currentItemAttributes;
}


@end
