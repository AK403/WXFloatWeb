//
//  WXFloatPopTransition.m
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/24.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import "WXFloatPopTransition.h"

@implementation WXFloatPopTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    UIView *bgView = [[UIView alloc] initWithFrame:containerView.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    [containerView insertSubview:bgView belowSubview:toVC.view];
    
    // view frame
    CGRect fromVCInitialFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect fromVCFinalFrame = CGRectOffset(fromVCInitialFrame, [UIScreen mainScreen].bounds.size.width, 0);
    
    CGRect toVCFinalFrame = [transitionContext finalFrameForViewController:toVC];
    CGRect toVCInitialFrame = toVCFinalFrame;
    
    fromVC.view.frame = fromVCInitialFrame;
    toVC.view.frame = toVCInitialFrame;
    
    // page attribute
    UIColor* fromVCOldShadowColor = (nil != fromVC.view.layer.shadowColor ? [UIColor colorWithCGColor:fromVC.view.layer.shadowColor] : nil);
    CGSize fromVCOldShadowOffset = fromVC.view.layer.shadowOffset;
    CGFloat fraomVCOldShadowOpacity = fromVC.view.layer.shadowOpacity;
    fromVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    fromVC.view.layer.shadowOffset = CGSizeMake(-0.8, 0);
    fromVC.view.layer.shadowOpacity = 0.6;
    
    toVC.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, - [UIScreen mainScreen].bounds.size.width / 4, 0);
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIViewAnimationOptions option = 0;
    if (self.isInteracting) {
        option = UIViewAnimationOptionCurveLinear;
    }
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        fromVC.view.frame = fromVCFinalFrame;
        toVC.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        BOOL isComplete = !transitionContext.transitionWasCancelled;

        // restore view state
        fromVC.view.layer.shadowColor = fromVCOldShadowColor.CGColor;
        fromVC.view.layer.shadowOffset = fromVCOldShadowOffset;
        fromVC.view.layer.shadowOpacity = fraomVCOldShadowOpacity;
        
        toVC.view.transform = CGAffineTransformIdentity;
        toVC.view.frame = toVCFinalFrame;
        
        if (NO == isComplete) {
            fromVC.view.frame = fromVCInitialFrame;
        }
        else {
            fromVC.view.frame = fromVCFinalFrame;
        }
        
        [bgView removeFromSuperview];
        
        [transitionContext completeTransition:isComplete];
    }];
}

@end
