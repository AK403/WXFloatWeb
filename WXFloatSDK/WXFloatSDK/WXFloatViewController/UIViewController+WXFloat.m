//
//  UIViewController+WXFloat.m
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/28.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import "UIViewController+WXFloat.h"
#import "WXFloatManager.h"
#import <objc/runtime.h>
#import "WXFloatUtil.h"

@implementation UIViewController (WXFloat)

static const char * WXTransitionObjectKey = "WXTransitionObjectKey";
static const char * WXMinimizeActionKey = "WXMinimizeAction";

- (WXFloatTransitionObject *)transitionObject
{
    return objc_getAssociatedObject(self, WXTransitionObjectKey);
}

- (void)setTransitionObject:(WXFloatTransitionObject *)transitionObject
{
    objc_setAssociatedObject(self, WXTransitionObjectKey, transitionObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (dispatch_block_t)minimizeAction
{
    return objc_getAssociatedObject(self, WXMinimizeActionKey);
}

- (void)setMinimizeAction:(dispatch_block_t)minimizeAction
{
    objc_setAssociatedObject(self, WXMinimizeActionKey, minimizeAction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)tryInitTransitionObject
{
    if (self.transitionObject == nil)
    {
        self.transitionObject = [[WXFloatTransitionObject alloc] init];
        self.transitionObject.weakVC = self;
        
        [self.view addGestureRecognizer:self.transitionObject.popBackInteractivePopGesture];
        
        if (self.navigationController)
        {
            self.navigationController.transitioningDelegate = self.transitionObject;
        }
        else
        {
            self.transitioningDelegate = self.transitionObject;
        }
    }
}

#pragma mark - pubic method

- (void)wf_presentSelfAnimated:(BOOL)flag navi:(UINavigationController *)navi completion:(dispatch_block_t)completion presentingViewController:(UIViewController *)presentingViewController
{
    [[WXFloatManager sharedInstance] setUp];
    [self tryInitTransitionObject];
    
    if ([self wf_isFloating])
    {
        self.transitionObject.transtionStyle = WXFloatTransitionStyleMinimize;
        WXFloatWindow *window = [WXFloatManager sharedInstance].floatWindow;
        [window handleWhenAutoMaximize:self];
    }
    else
    {
        self.transitionObject.transtionStyle = WXFloatTransitionStyleDefault;
    }
    
    if (navi)
    {
        [presentingViewController presentViewController:navi animated:flag completion:completion];
    }
    else
    {
        [presentingViewController presentViewController:self animated:flag completion:completion];
    }
}

- (void)wf_dismissSelfAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    if ([self wf_isFloating])
    {
        self.transitionObject.transtionStyle = WXFloatTransitionStyleMinimize;
        WXFloatWindow *window = [WXFloatManager sharedInstance].floatWindow;
        [window handleWhenAutoMinimize:self];
    }
    else
    {
        self.transitionObject.transtionStyle = WXFloatTransitionStyleDefault;
    }
    
    if (self.navigationController)
    {
        [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    }
    else
    {
        [self dismissViewControllerAnimated:flag completion:completion];
    }
}

- (void)wf_minimizeSelf
{
    [WXFloatManager sharedInstance].floatWindow.minimizeVC = self;
    [WXFloatManager sharedInstance].floatWindow.minimizeNavi = self.navigationController;
    
    [self wf_dismissSelfAnimated:YES completion:nil];
}

- (void)wf_maximizeSelf
{
    [WXFloatManager sharedInstance].floatWindow.minimizeVC = self;
    [WXFloatManager sharedInstance].floatWindow.minimizeNavi = self.navigationController;

    UIViewController *presentingVC = [WXFloatUtil currentViewController];
    [self wf_presentSelfAnimated:YES  navi:self.navigationController completion:nil presentingViewController:presentingVC];
}

// 是否处于浮窗状态（即被保存）
- (BOOL)wf_isFloating
{
    if ([WXFloatManager sharedInstance].floatWindow.minimizeVC == self)
    {
        return YES;
    }
    return NO;
}

- (void)wf_setupFloating
{
    [WXFloatManager sharedInstance].floatWindow.minimizeVC = self;
    [WXFloatManager sharedInstance].floatWindow.minimizeNavi = self.navigationController;
}

// 取消自己的浮窗状态
- (void)wf_cancelFloating
{
    if ([self wf_isFloating])
    {
        [WXFloatManager sharedInstance].floatWindow.minimizeVC = nil;
        [WXFloatManager sharedInstance].floatWindow.minimizeNavi = nil;
    }
}

- (void)wf_configMimimizeAction:(dispatch_block_t)minimizeAction
{
    self.minimizeAction = minimizeAction;
}
@end
