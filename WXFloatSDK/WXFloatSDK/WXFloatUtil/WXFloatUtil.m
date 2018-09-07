
//
//  WXFloatUtil.m
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/24.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import "WXFloatUtil.h"

@implementation WXFloatUtil

static NSString *kWXFloatRecordPointXKey = @"kWXFloatRecordPointXKey";
static NSString *kWXFloatRecordPointYKey = @"kWXFloatRecordPointYKey";

+ (CGFloat) statusBarHeight
{
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

+ (NSUInteger)currentTimeStamp
{
    return [[NSDate date] timeIntervalSince1970] * 1000;
}


+ (void)impactFeedback
{
    if (@available(iOS 10.0, *))
    {
        UIImpactFeedbackGenerator* generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        [generator prepare];
        [generator impactOccurred];
    }
}

+ (UIViewController *)currentViewController
{
    UIViewController *vc = [UIApplication sharedApplication].delegate.window.rootViewController;
    while (1)
    {
        if ([vc isKindOfClass:[UITabBarController class]])
        {
            vc = ((UITabBarController *) vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]])
        {
            vc = ((UINavigationController *) vc).visibleViewController;
        }
        if (vc.presentedViewController)
        {
            vc = vc.presentedViewController;
        }
        else
        {
            break;
        }
    }
    return vc;
}

+ (BOOL)isSweepFast:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    CGPoint velocity = [recognizer velocityInView:recognizer.view];
    CGFloat kVeclocityFastValue = 200;
    BOOL isSweepFast = (velocity.x > kVeclocityFastValue ? YES : NO);
    return isSweepFast;
}

+ (CGPoint)lastRecordPoint
{
    NSNumber *xNumber = [[NSUserDefaults standardUserDefaults] objectForKey:kWXFloatRecordPointXKey];
    NSNumber *yNumber = [[NSUserDefaults standardUserDefaults] objectForKey:kWXFloatRecordPointYKey];
    if ([xNumber isKindOfClass:[NSNumber class]] &&
        [yNumber isKindOfClass:[NSNumber class]])
    {
        return CGPointMake(xNumber.floatValue, yNumber.floatValue);
    }
    else
    {
        return CGPointZero;
    }
}

+ (void)recordThePoint:(CGPoint)point
{
    [[NSUserDefaults standardUserDefaults] setObject:@(point.x) forKey:kWXFloatRecordPointXKey];
    [[NSUserDefaults standardUserDefaults] setObject:@(point.y) forKey:kWXFloatRecordPointYKey];

}
@end
