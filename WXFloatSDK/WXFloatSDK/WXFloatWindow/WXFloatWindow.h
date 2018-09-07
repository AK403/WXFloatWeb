//
//  WXFloatWindow.h
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/23.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXFloatIcon.h"

@interface WXFloatWindow : UIWindow

@property (nonatomic, strong) UIView<WXFloatIconProtocol> *floatIcon;
@property (nonatomic, strong) UINavigationController *minimizeNavi;
@property (nonatomic, strong) UIViewController *minimizeVC;

- (void)handleMinimizeProgress:(CGFloat)progress recognizer:(UIScreenEdgePanGestureRecognizer *)recognizer currentViewController:(UIViewController *)currentViewController;


// 处理非手势的自动化缩小动画时，进行同时需要的操作
- (void)handleWhenAutoMinimize:(UIViewController *)currentVC;

// 处理非手势的自动化放大动画时，进行同时需要的操作
- (void)handleWhenAutoMaximize:(UIViewController *)currentVC;

@end
