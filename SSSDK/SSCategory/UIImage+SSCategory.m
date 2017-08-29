//
//  UIImage+SSCategory.m
//  SSSDK
//
//  Created by 李飞恒 on 2017/8/29.
//  Copyright © 2017年 SanshengIT. All rights reserved.
//

#import "UIImage+SSCategory.h"
#import <Accelerate/Accelerate.h>
#import <float.h>
#import <UIImage+GIF.h>
#import <UIImage+AFNetworking.h>

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

@implementation UIImage (SSCategory)

+ (UIImage*)createImageWithColor: (UIColor*) color
{
    // 画布大小
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 在当前画布上开启绘图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 画笔
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置画笔颜色
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 填充画布
    CGContextFillRect(context, rect);
    // 取得画布中的图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束绘图上下文
    UIGraphicsEndImageContext();
    return theImage;
}

+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = (UIImage *)UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)setImageSize:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillRect(context, rect);
    
    UIImage *image = (UIImage *)UIGraphicsGetImageFromCurrentImageContext()
    ;
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithName:(NSString *)name
{
    UIImage *image = nil;
    if (iOS7) { // 处理iOS7的情况
        NSString *newName = [name stringByAppendingString:@"_os7"];
        image = [UIImage imageNamed:newName];
    }
    
    if (image == nil) {
        image = [UIImage imageNamed:name];
    }
    return image;
}


+ (instancetype)imageColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *pureColorImage = (UIImage *)UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pureColorImage;
}

+ (instancetype)imageColor:(UIColor *)color {
    return [UIImage imageColor:color size:CGSizeMake(100, 100)];
}

+ (instancetype)imageHexColor:(NSString *)hexColor size:(CGSize)size {
    return [UIImage imageColor:[UIColor colorWithString:hexColor] size:size];
}

+ (instancetype)imageHexColor:(NSString *)hexColor {
    return [UIImage imageHexColor:hexColor size:CGSizeMake(100, 100)];
}




+ (UIImage *)blurryImage:(UIImage *)image blur:(CGFloat)blur {
    if ((blur <= 0.0f) || (blur >= 1.0f)) {
        blur = 0.5f;
    }
    
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL,
                                       0, 0, boxSize, boxSize, NULL,
                                       kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"错误的 %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    //    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}



+ (instancetype)resizableImage:(NSString *)name leftRatio:(CGFloat)leftRatio topRatio:(CGFloat)topRatio {
    UIImage *image = [UIImage imageNamed:name];
    CGFloat left = image.size.width * leftRatio;
    CGFloat top = image.size.height * topRatio;
    return (UIImage *)[image stretchableImageWithLeftCapWidth:left topCapHeight:top];
}


+ (instancetype)imageSize:(CGSize)size borderColor:(UIColor *)borderColor backgroundColor:(UIColor *)backgroundColor radius:(CGFloat)radius {
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect outerRect = CGRectMake(0, 0, size.width, size.height);
    CGMutablePathRef outerPath = createRoundedRectForRect(outerRect, radius);
    
    CGContextSaveGState(context);
    CGContextAddRect(context, CGRectMake(0, 0, size.width, size.height));
    CGContextAddPath(context, outerPath);
    CGContextEOClip(context);
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextAddPath(context, outerPath);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGFloat innerMargin = -1.0f;
    CGRect innerRect = CGRectInset(outerRect, innerMargin, innerMargin);
    CGMutablePathRef innerPath = createRoundedRectForRect(innerRect, radius);
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, backgroundColor.CGColor);
    CGContextAddPath(context, innerPath);
    CGContextClip(context);
    CGContextAddPath(context, innerPath);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CFRelease(outerPath);
    CFRelease(innerPath);
    
    return (UIImage *)UIGraphicsGetImageFromCurrentImageContext();
}

CGMutablePathRef createRoundedRectForRect(CGRect rect, CGFloat radius) {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMinY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMinY(rect), radius);
    CGPathCloseSubpath(path);
    
    return path;
}

+ (instancetype)circleImageName:(NSString*)imageName round:(CGFloat)round {
    UIImage *image = [UIImage imageNamed:imageName];
    
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGRect rect = CGRectMake(round, round, image.size.width - round * 2.0f, image.size.height - round * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = (UIImage *)UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+ (instancetype)imageWithPNGFileName:(NSString*)imageName {
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:path];
}
+ (instancetype)imageWithMPEGFileName:(NSString*)imageName {
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"mpeg"];
    return [UIImage imageWithContentsOfFile:path];
}


+ (instancetype)resizableImage:(NSString *)name size:(CGSize)size {
    UIImage *image = [UIImage imageNamed:name];
    CGFloat x = image.size.width * size.width;
    CGFloat y = image.size.height * size.height;
    return [image stretchableImageWithLeftCapWidth:x topCapHeight:y];
}


@end
