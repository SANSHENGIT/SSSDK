//
//  UIImageView+SSCategory.m
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/29.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "UIImageView+SSCategory.h"
#import "UIView+SSCategory.h"
#import "CALayer+SSCategory.h"
#import "UIImage+SSCategory.h"


@implementation UIImageView (SSCategory)

+ (instancetype)imageViewWithFrame:(CGRect)frame
{
    return [UIImageView imageView:nil frame:frame];
}

+ (instancetype)imageView:(NSString *)imageName frame:(CGRect)frame
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}

+ (instancetype)radiusImageViewWithFrame:(CGRect)frame
{
    UIImageView *imageView = [UIImageView imageView:nil frame:frame];
    [imageView setCornerRadius:kPx(imageView.width)];
    return imageView;
}


- (void)setImageBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)brderColor
{
    [self.layer setLayerBorderWidth:borderWidth borderColor:brderColor];
    self.layer.masksToBounds = YES;
    self.userInteractionEnabled = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}



- (instancetype)imageWithPNGName:(NSString *)imageName frame:(CGRect)frame
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageWithPNGFileName:imageName];
    return imageView;
}

- (instancetype)imageWithMPEGName:(NSString *)imageName frame:(CGRect)frame
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageWithMPEGFileName:imageName];
    return imageView;
}

- (void)ss_setImageWithURL:(NSString *)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]];
}

- (void)setImageWithURL:(NSString *)url defineImageName:(NSString *)imageName
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:imageName]];
}
- (void)setImageWithURL:(NSString *)url defineImage:(UIImage *)image
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:image];
}

- (void)setImageWithURL:(NSString *)url defineImage:(NSString *)image options:(SDWebImageOptions)options
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:image] options:options];
}


- (void)coreBlurWithBlurNumber:(CGFloat)blur
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage= [CIImage imageWithCGImage:self.image.CGImage];
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey]; [filter setValue:@(blur) forKey:@"inputRadius"];
    //模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:[result extent]];
    self.image = [UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
}

@end
