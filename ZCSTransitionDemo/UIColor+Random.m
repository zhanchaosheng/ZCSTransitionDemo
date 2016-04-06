//
//  UIColor+Random.m
//  QuartzFun
//
//  Created by Cusen on 15/8/20.
//  Copyright © 2015年 cusen. All rights reserved.
//

#import "UIColor+Random.h"

#define Arc4Random_Max 0x100000000LL

@implementation UIColor (Random)

+ (UIColor *)randomColor
{
    CGFloat red = (CGFloat)arc4random() / (CGFloat)Arc4Random_Max;
    CGFloat blue = (CGFloat)arc4random() / (CGFloat)Arc4Random_Max;
    CGFloat green = (CGFloat)arc4random() / (CGFloat)Arc4Random_Max;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}
@end
