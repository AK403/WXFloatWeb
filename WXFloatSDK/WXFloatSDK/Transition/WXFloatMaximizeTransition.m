//
//  WXFloatMaximizeTransition.m
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/24.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import "WXFloatMaximizeTransition.h"
#import "WXFloatManager.h"

@interface WXFloatMaximizeTransition()<CAAnimationDelegate>

@property (nonatomic, strong)id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation WXFloatMaximizeTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    
    //获取源控制器 注意不要写成 UITransitionContextFromViewKey
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //获取目标控制器 注意不要写成 UITransitionContextToViewKey
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect fromVCInitialFrame = [transitionContext initialFrameForViewController:fromVc];
    
    CGRect toVCFinalFrame = [transitionContext finalFrameForViewController:toVc];
    
    fromVc.view.frame = fromVCInitialFrame;
    toVc.view.frame = toVCFinalFrame;
    
    UIView *betweenView = [[UIView alloc] init];
    betweenView.frame = toVc.view.frame;
    betweenView.backgroundColor = [UIColor blackColor];
    betweenView.alpha = 0;
    
    //注意：添加顺序和push动画相反
    UIView *containView = [transitionContext containerView];
    [containView addSubview:fromVc.view];
    [containView addSubview:betweenView];
    [containView addSubview:toVc.view];
    
    UIView *moveView = [[[WXFloatManager sharedInstance] floatWindow] floatIcon];
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRoundedRect:moveView.frame cornerRadius:moveView.frame.size.width/2];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRoundedRect:fromVc.view.frame cornerRadius:moveView.frame.size.width/2];
    
    //注意是赋值给fromVc视图layer的mask
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    toVc.view.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id)startPath.CGPath;
    animation.toValue = (__bridge id)endPath.CGPath;
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.delegate = self;
    [maskLayer addAnimation:animation forKey:nil];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:[self transitionDuration:transitionContext]];
    betweenView.alpha = 1;
    [UIView commitAnimations];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.transitionContext completeTransition:YES];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}
@end
