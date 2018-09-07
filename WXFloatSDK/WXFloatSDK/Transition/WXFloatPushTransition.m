//
//  WXFloatPushTransition.m
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/23.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import "WXFloatPushTransition.h"

@implementation WXFloatPushTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    CGRect fromVCRect = fromVC.view.frame;
    fromVCRect.origin.x = 0;
    fromVC.view.frame = fromVCRect;
    [container addSubview:toVC.view];
    
    CGRect toVCRect = toVC.view.frame;
    toVCRect.origin.x = [UIScreen mainScreen].bounds.size.width;
    toVC.view.frame = toVCRect;
    
    fromVCRect.origin.x = -[UIScreen mainScreen].bounds.size.width;
    toVCRect.origin.x = 0;
    
    UIColor* toVCOldShadowColor = (nil != toVC.view.layer.shadowColor ? [UIColor colorWithCGColor:toVC.view.layer.shadowColor] : nil);
    CGSize toVCOldShadowOffset = toVC.view.layer.shadowOffset;
    CGFloat toVCOldShadowOpacity = toVC.view.layer.shadowOpacity;
    toVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    toVC.view.layer.shadowOffset = CGSizeMake(-0.8, 0);
    toVC.view.layer.shadowOpacity = 0.6;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromVC.view.frame = fromVCRect;
        toVC.view.frame = toVCRect;
        
    } completion:^(BOOL finished) {
        [fromVC.view removeFromSuperview];
        
        toVC.view.layer.shadowColor = toVCOldShadowColor.CGColor;
        toVC.view.layer.shadowOffset = toVCOldShadowOffset;
        toVC.view.layer.shadowOpacity = toVCOldShadowOpacity;
        
        [transitionContext completeTransition:finished];//动画结束、取消必须调用
    }];
}

@end
