//
//  UIViewController+WXFloat.h
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/28.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXFloatTransitionObject.h"

@protocol WXFloatViewControllerProtocol<NSObject>

@optional

// 返回当前页面默认的图片
- (UIImage *)wf_defaultImage;


@end

@interface UIViewController (WXFloat)

@property (nonatomic, strong) WXFloatTransitionObject *transitionObject;
@property (nonatomic, strong) dispatch_block_t minimizeAction;

// 退出当前页面，会根据是否为浮窗状态，做不同的页面推出动画
- (void)wf_dismissSelfAnimated:(BOOL)flag completion:(dispatch_block_t)completion;

// 推进当前页面，普通推入时，自动将present动画转成普通的push动画，如果是恢复页面，自动会做放大动画
- (void)wf_presentSelfAnimated:(BOOL)flag navi:(UINavigationController *)navi completion:(dispatch_block_t)completion presentingViewController:(UIViewController *)presentingViewController;

// 最小化自己，变成浮窗状态
- (void)wf_minimizeSelf;

// 最大化自己
- (void)wf_maximizeSelf;

// 判断自己是否为浮窗状态
- (BOOL)wf_isFloating;

//记录为浮窗状态
- (void)wf_setupFloating;

// 取消浮窗状态
- (void)wf_cancelFloating;

// 当被最小化的时候会被调用（可用于设置float icon的imageview）
- (void)wf_configMimimizeAction:(dispatch_block_t)minimizeAction;
@end
