//
//  WXFloatWindow.m
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/23.
//  Copyright © 2018年 AK403. All rights reserved.
//
#import "WXFloatWindow.h"
#import "WXFloatIcon.h"
#import "WXFloatRubbishCircleView.h"
#import "WXFloatMinimizeCircleView.h"
#import "UIView+WXFloatUtil.h"
#import "WXFloatUtil.h"
#import "WXFloatManager.h"
#import "UIViewController+WXFloat.h"
#import <objc/runtime.h>

@interface WXFloatWindow()<WXFloatMoveCalculatorDelegate>

@property (nonatomic, strong) UIView<WXFloatMinimizeCircleViewProtocol> *minimizeCircleView;
@property (nonatomic, strong) UIView<WXFloatRubbishCircleViewProtocol> *rubbishCircleView;
@property (nonatomic, assign) BOOL showingRubCircle;
@property (nonatomic, assign) BOOL hasSelectedRub;
@property (nonatomic, assign) CGPoint touchBeginPoint;
@property (nonatomic, assign) NSUInteger miniMizeBeginTime; // 手指响应的触发时间
@property (nonatomic, assign) BOOL lastSelected;
@property (nonatomic, strong) WXFloatMoveCalculator *moveCalculator;

@end

@implementation WXFloatWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.hidden = YES;
        [self setWindowLevel:UIWindowLevelNormal];
        [self addSubview:self.rubbishCircleView];
        [self addSubview:self.minimizeCircleView];
        [self addSubview:self.floatIcon];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.minimizeCircleView.wf_right = self.wf_width;
    self.minimizeCircleView.wf_bottom = self.wf_height;
    
    self.rubbishCircleView.wf_right = self.wf_width;
    self.rubbishCircleView.wf_bottom = self.wf_height;
}

#pragma mark - handle touch event
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL result = [self.floatIcon pointInside:[self.floatIcon convertPoint:point fromView:self] withEvent:event];
    return result;
}

// 返回接受触摸事件的view（touchesBegan）
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self || view == nil)
    {
        return nil;
    }

    return view;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.moveCalculator touchesBegan:touches withEvent:event];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [self.moveCalculator touchesMoved:touches withEvent:event];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self.moveCalculator touchesEnded:touches withEvent:event];
}

- (void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self.moveCalculator touchesCancel:touches withEvent:event];
}
#pragma mark - initlize getter
- (UIView<WXFloatIconProtocol> *)floatIcon
{
    if (!_floatIcon)
    {
        Class floatIconClass = [WXFloatManager sharedInstance].floatIconClass;
        _floatIcon = [[floatIconClass alloc] init];
        _floatIcon.frame = [floatIconClass floatIconFrame];
        CGPoint lastRectPoint = [WXFloatUtil lastRecordPoint];
        if (lastRectPoint.x > 0 &&
            lastRectPoint.x < [UIScreen mainScreen].bounds.size.width &&
            lastRectPoint.y > 0 &&
            lastRectPoint.y < [UIScreen mainScreen].bounds.size.height)
        {
            self.floatIcon.wf_point = lastRectPoint;
        }

        _floatIcon.hidden = YES;
    }
    return _floatIcon;
}

- (UIView<WXFloatRubbishCircleViewProtocol> *)rubbishCircleView
{
    if (!_rubbishCircleView)
    {
        Class rubbishClass = [WXFloatManager sharedInstance].rubbishClass;
        _rubbishCircleView = [[rubbishClass alloc] init];
        _rubbishCircleView.wf_size = [WXFloatRubbishCircleView rubbishCircleSize];
    }
    return _rubbishCircleView;
}

- (UIView<WXFloatMinimizeCircleViewProtocol> *)minimizeCircleView
{
    if (!_minimizeCircleView)
    {
        Class minimizeClass = [WXFloatManager sharedInstance].minimizeViewClass;
        _minimizeCircleView = [[minimizeClass alloc] init];
        _minimizeCircleView.wf_size = [WXFloatMinimizeCircleView minimizeCircleSize];
    }
    return _minimizeCircleView;
}

- (WXFloatMoveCalculator *)moveCalculator
{
    if (!_moveCalculator)
    {
        _moveCalculator = [[WXFloatMoveCalculator alloc] init];
        _moveCalculator.delegate = self;
        _moveCalculator.moveingView = self.floatIcon;
        _moveCalculator.edgeOffsetTop = [[UIApplication sharedApplication] statusBarFrame].size.height + 66;
        _moveCalculator.edgeOffsetBottom = 66;
        _moveCalculator.edgeOffsetX = 20;
    }
    return _moveCalculator;
}

#pragma mark - handle gesture rubbish methods
- (void)showRubbishCircleView
{
    self.showingRubCircle = YES;
    self.rubbishCircleView.hidden = NO;
    [self.rubbishCircleView updateProgress:1];
}

- (void)hideRubbishCircleView
{
    self.showingRubCircle = NO;
    self.rubbishCircleView.hidden = YES;
    [self.rubbishCircleView updateProgress:0];
}

#pragma mark - WXFloatMoveCalculatorDelegate
- (void)cal_didTap
{
    if (!self.minimizeVC)
    {
        return;
    }
    
    UIViewController *currentVC = [WXFloatUtil currentViewController];
    [self.minimizeVC wf_presentSelfAnimated:YES navi:self.minimizeNavi completion:nil presentingViewController:currentVC];
}

- (void)cal_onTouchBeginPoint:(CGPoint)point
{
    self.touchBeginPoint = point;
}

- (void)cal_onMovingPoint:(CGPoint)point
{
    self.floatIcon.wf_point = point;
    
    BOOL selected = [self.rubbishCircleView inRubbishCirclePoint:point];
    
    if(!self.showingRubCircle)
    {
        [self.rubbishCircleView updateProgress:0];
        [UIView animateWithDuration:0.15 animations:^{
            [self showRubbishCircleView];
        } completion:^(BOOL finished) {
        }];
        return;
    }
    
    if (!self.hasSelectedRub && selected)
    {
        [WXFloatUtil impactFeedback];
        [UIView animateWithDuration:0.1 animations:^{
            [self.rubbishCircleView configSelectedState];
        }];
    } else if (self.hasSelectedRub && !selected)
    {
        [self.rubbishCircleView updateProgress:1];
    }
    
    self.hasSelectedRub = selected;
}

- (void)cal_onMoveEndPoint:(CGPoint)currentPoint willResultPoint:(CGPoint)resultPoint
{
    if (self.hasSelectedRub)
    {
        self.floatIcon.hidden = YES;
        self.minimizeVC = nil;
        self.minimizeNavi = nil;
        self.hasSelectedRub = NO;
        self.floatIcon.wf_point = self.touchBeginPoint;
        [WXFloatUtil recordThePoint:self.floatIcon.wf_point];
    }
    else
    {
        [UIView animateWithDuration:0.1 animations:^{
            self.floatIcon.wf_point = resultPoint;
        } completion:^(BOOL finished) {
            [WXFloatUtil recordThePoint:self.floatIcon.wf_point];
        }];
    }
    
    [self hideRubbishCircleView];
}

- (void)cal_onMoveCancel
{
    
}

#pragma mark - handle gesture minimize methods
- (void)handleMinimizeProgress:(CGFloat)progress recognizer:(UIScreenEdgePanGestureRecognizer *)recognizer currentViewController:(UIViewController *)currentViewController
{
    CGPoint location = [recognizer locationInView:recognizer.view];
    CGPoint translation = [recognizer translationInView:recognizer.view];
    
    //当前viewcontroller是最大化而来
    if(currentViewController == self.minimizeVC)
    {
        if(recognizer.state == UIGestureRecognizerStateBegan)
        {
        
        }
        else if (recognizer.state == UIGestureRecognizerStateChanged)
        {
            [self handleAniWhenGesPopping:recognizer progress:progress currentViewController:currentViewController poping:YES];
        }
        else if (recognizer.state == UIGestureRecognizerStateEnded)
        {
            BOOL isSweepFast = [WXFloatUtil isSweepFast:recognizer];
            
            if (progress > 0.5 || isSweepFast)
            {
                [self handleAniWhenGesMinimize:recognizer progress:progress];
            }
            else
            {
                [self handleAniWhenGesPopping:recognizer progress:progress currentViewController:currentViewController poping:NO];
            }

        }
        else
        {
            
        }
    }
    else
    {
        // 处理正常进入的viewcontroller的手势退出逻辑
        BOOL selected = [self.minimizeCircleView inMinizeCirclePoint:CGPointMake(translation.x, location.y)];
        if(recognizer.state == UIGestureRecognizerStateBegan)
        {
            self.miniMizeBeginTime = [WXFloatUtil currentTimeStamp];
        }
        else if (recognizer.state == UIGestureRecognizerStateChanged)
        {
            NSUInteger currentTime = [WXFloatUtil currentTimeStamp];
            NSUInteger timeOffset = currentTime - self.miniMizeBeginTime;
            if (timeOffset < 200)
            {
                return;
            }
            if (!selected)
            {
                [self.minimizeCircleView  updateProgress:MIN(progress * 2, 1)];
            }
            else
            {
                if (!self.lastSelected)
                {
                    [self.minimizeCircleView configSelectedState];
                    [WXFloatUtil impactFeedback];
                }
            }
            self.lastSelected = selected;
        }
        else if (recognizer.state == UIGestureRecognizerStateEnded)
        {
            if (selected)
            {
                self.minimizeNavi = currentViewController.navigationController;
                self.minimizeVC = currentViewController;
                
                [self handleAniWhenGesMinimize:recognizer progress:progress];
            }
            
            [UIView animateWithDuration:0.2 animations:^{
                [self.minimizeCircleView updateProgress:0];
            } completion:^(BOOL finished) {
                
            }];
        }
        else
        {
            
        }
    }
}

#pragma mark - handle something about animation in window
// 当自动最小化的时候window配合做的动画
- (void)handleWhenAutoMinimize:(UIViewController *)currentVC
{
    if (self.minimizeVC == currentVC || self.minimizeNavi == currentVC)
    {
        if (self.minimizeVC.minimizeAction)
        {
            self.minimizeVC.minimizeAction();
        }
        self.floatIcon.hidden = NO;
        self.floatIcon.alpha = 0;
        [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.floatIcon.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
}

// 当自动最大化的时候window配合做的动画
- (void)handleWhenAutoMaximize:(UIViewController *)currentVC
{
    if (self.minimizeVC == currentVC || self.minimizeNavi == currentVC)
    {
        self.floatIcon.hidden = NO;
        self.floatIcon.alpha = 1;
        [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.floatIcon.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

// 通过手势返回作出的最小化动作
- (void)handleAniWhenGesMinimize:(UIScreenEdgePanGestureRecognizer *)recognizer progress:(CGFloat)progress
{
    UIView *snapshotView = [recognizer.view snapshotViewAfterScreenUpdates:NO];
    [self insertSubview:snapshotView belowSubview:self.rubbishCircleView];
    
    snapshotView.wf_left = recognizer.view.wf_width * progress;
    snapshotView.maskView = [[UIView alloc] initWithFrame:snapshotView.bounds];
    snapshotView.maskView.backgroundColor = [UIColor blueColor];
    snapshotView.maskView.layer.cornerRadius = snapshotView.wf_width/2;
    
    // 缩小动画 & 颜色淡入动画
    [UIView animateWithDuration:0.3 animations:^{
        snapshotView.maskView.transform = CGAffineTransformMakeScale(self.floatIcon.wf_width / snapshotView.wf_width, self.floatIcon.wf_height / snapshotView.wf_height);
        snapshotView.center = self.floatIcon.center;
        self.floatIcon.alpha = 1;
    } completion:^(BOOL finished) {
        recognizer.view.hidden = NO;
        [snapshotView removeFromSuperview];
        self.floatIcon.hidden = NO;
    }];
    
    if (self.minimizeVC.minimizeAction)
    {
        self.minimizeVC.minimizeAction();
    }
}

//在手指滑动过程中需要配合做的动画(poping yes代表就是pop过程，no代表就是页面返回)
- (void)handleAniWhenGesPopping:(UIScreenEdgePanGestureRecognizer *)recognizer progress:(CGFloat)progress currentViewController:(UIViewController *)currentViewController poping:(BOOL)popping
{
    if (self.minimizeVC == currentViewController)
    {
        if (popping)
        {
            self.floatIcon.hidden = NO;
            self.floatIcon.alpha = MIN(progress * 2, 1);
        }
        else
        {
            self.floatIcon.hidden = YES;
            self.floatIcon.alpha = 0;
        }
    }
}

@end
