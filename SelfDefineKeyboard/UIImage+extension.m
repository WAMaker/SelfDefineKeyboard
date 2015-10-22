//
//  UIImage+extension.m
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/10/21.
//  Copyright © 2015年 wamaker. All rights reserved.
//

#import "UIImage+extension.h"

@implementation UIImage (extension)

+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
