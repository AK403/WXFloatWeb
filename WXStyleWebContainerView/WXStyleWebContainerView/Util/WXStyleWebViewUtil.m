//
//  WXStyleWebViewUtil.m
//  WXStyleWebView
//
//  Created by AK403 on 2018/9/3.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import "WXStyleWebViewUtil.h"

@implementation WXStyleWebViewUtil

+ (BOOL)isPhoneX
{
    if ([UIScreen mainScreen].bounds.size.width == 375 &&
        [UIScreen mainScreen].bounds.size.height == 812)
    {
        return YES;
    }
    return NO;
}

+ (CGFloat)bottomTabbarHeight
{
    CGFloat height = [self isPhoneX] ? (49+34) : 49;
    return height;
}
@end
