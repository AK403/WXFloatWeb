//
//  WXFloatTransitionObject.m
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/28.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import "WXFloatTransitionObject.h"
#import "WXFloatPushTransition.h"
#import "WXFloatPopTransition.h"
#import "WXFloatMaximizeTransition.h"
#import "WXFloatManager.h"
#import "UIView+WXFloatUtil.h"
#import "WXFloatUtil.h"
#import "WXFloatMinimizeTransition.h"

@interface WXFloatTransitionObject()

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@property (nonatomic, assign) BOOL isInteractive;
@property (nonatomic, assign) NSUInteger miniMizeBeginTime; // 手指响应的触发时间
@property (nonatomic, assign) BOOL lastSelected;

@end

@implementation WXFloatTransitionObject

- (instancetype)init
{
    if (self = [super init])
    {
        self.popBackInteractivePopGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(handlePopBackInteractivePopGesture:)];
        self.popBackInteractivePopGesture.delegate = self;
        self.popBackInteractivePopGesture.edges = UIRectEdgeLeft;
        self.popBackInteractivePopGesture.delegate = self;
    }
    return self;
}

- (void)handlePopBackInteractivePopGesture:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    CGFloat width = recognizer.view.bounds.size.width;
    if (0 == width)
    {
        return;
    }
    
    CGPoint translation = [recognizer translationInView:recognizer.view];
    CGFloat progress = translation.x / width;
    progress = MIN(1.0, MAX(0.0, progress));
    
    [self handlePopProgress:progress recognizer:recognizer];
    [self handleMinimizeProgress:progress recognizer:recognizer];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (gestureRecognizer == self.popBackInteractivePopGesture)
    {
        return YES;
    }
    return NO;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    if (self.transtionStyle == WXFloatTransitionStyleDefault)
    {
        WXFloatPushTransition *pushTransition = [[WXFloatPushTransition alloc] init];
        return pushTransition;
    }
    else if (self.transtionStyle == WXFloatTransitionStyleMinimize)
    {
        return [[WXFloatMaximizeTransition alloc] init];
    }
    return nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    if (self.transtionStyle == WXFloatTransitionStyleDefault)
    {
        WXFloatPopTransition *popTransition = [[WXFloatPopTransition alloc] init];
        popTransition.isInteracting = self.isInteractive;
        
        return popTransition;
    }
    else if (self.transtionStyle == WXFloatTransitionStyleMinimize)
    {
        return [[WXFloatMinimizeTransition alloc] init];
    }
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    if (self.transtionStyle == WXFloatTransitionStyleDefault)
    {
        return self.interactivePopTransition;
    }
    return nil;
}

#pragma mark - private method
//处理pop动画的逻辑
- (void)handlePopProgress:(CGFloat)progress recognizer:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        self.isInteractive = YES;
        self.transtionStyle = WXFloatTransitionStyleDefault;
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.weakVC.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    else if(recognizer.state == UIGestureRecognizerStateChanged)
    {
        if (progress >= 1.0f) {
            progress = 0.99f;
        }
        
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        BOOL isSweepFast = [WXFloatUtil isSweepFast:recognizer];
        
        if(progress > 0.5 || isSweepFast)
        {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else
        {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
    }
    else
    {
        self.isInteractive = NO;
    }
}

- (void)handleMinimizeProgress:(CGFloat)progress recognizer:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    [[WXFloatManager sharedInstance].floatWindow handleMinimizeProgress:progress recognizer:recognizer currentViewController:self.weakVC];
}
@end
