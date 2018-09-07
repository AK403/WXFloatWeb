//
//  WXFloatUtil.h
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/24.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define WXFloat_SrcName(file)               [@"WXFloatBundle.bundle" stringByAppendingPathComponent:file]
#define WXFloat_FrameworkSrcName(file)      [@"Frameworks/WXFloatSDK.framework/WXFloatBundle.bundle" stringByAppendingPathComponent:file]
#define WXFloat_Image(file)                 [UIImage imageNamed:WXFloat_SrcName(file)] ? :[UIImage imageNamed:WXFloat_FrameworkSrcName(file)]


@interface WXFloatUtil : NSObject

+ (CGFloat)statusBarHeight;

+ (NSUInteger)currentTimeStamp;

+ (void)impactFeedback;

+ (UIViewController *)currentViewController;

+ (BOOL)isSweepFast:(UIScreenEdgePanGestureRecognizer *)recognizer;

+ (CGPoint)lastRecordPoint;

+ (void)recordThePoint:(CGPoint)point;
@end
