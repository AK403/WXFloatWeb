//
//  WXFloatMoveCalculator.m
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/23.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import "WXFloatMoveCalculator.h"
#import "UIView+WXFloatUtil.h"
#import <UIKit/UIKit.h>

@interface WXFloatMoveCalculator()

@property(nonatomic, assign) BOOL enableHandleMove;
@property(nonatomic, assign) CGPoint startPoint;

@end

static const CGFloat kMinDistance = 5;

@implementation WXFloatMoveCalculator

-(id) init
{
    self = [super init];
    if (self)
    {
        self.startPoint = CGPointZero;
        self.edgeOffsetTop = 3;
        self.edgeOffsetBottom = 3;
        self.edgeOffsetX = 3;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView* floatView = self.moveingView;
    CGPoint point = [[touches anyObject] locationInView:floatView];
    
    self.startPoint = point;
    self.enableHandleMove = NO;
    
    if ([self.delegate respondsToSelector:@selector(cal_onTouchBeginPoint:)])
    {
        [self.delegate cal_onTouchBeginPoint:floatView.frame.origin];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    if (touch.phase != UITouchPhaseMoved)
    {
        return;
    }
    
    UIView* floatView = self.moveingView;
    
    //计算位移=当前位置-起始位置
    CGPoint point = [touch locationInView:floatView];
    float dx = point.x - self.startPoint.x;
    float dy = point.y - self.startPoint.y;

    if (fabsf(dx) >= kMinDistance || fabsf(dy) >= kMinDistance )
    {
        self.enableHandleMove = YES;
    }
    
    if (self.enableHandleMove == NO)
    {
        return;
    }
    
    //计算移动后的view中心点
    CGPoint origin = CGPointMake(floatView.wf_left + dx, floatView.wf_top + dy);
    
    CGFloat minX = 0;
    CGFloat maxX = [UIScreen mainScreen].bounds.size.width - floatView.wf_width;
    CGFloat minY = 0;
    CGFloat maxY = [UIScreen mainScreen].bounds.size.height - floatView.wf_height;
    
    origin.x = MAX(minX, origin.x);
    origin.x = MIN(maxX, origin.x);
    
    origin.y = MAX(minY, origin.y);
    origin.y = MIN(maxY, origin.y);
    
    [self.delegate cal_onMovingPoint:origin];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.enableHandleMove)
    {
        if ([self.delegate respondsToSelector:@selector(cal_didTap)])
        {
            [self.delegate cal_didTap];
        }
        return;
    }
    
    UIView* floatView = self.moveingView;
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:floatView];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    // 计算resultX
    CGFloat resultX = floatView.wf_left;
    if (floatView.wf_centerX < screenWidth/ 2)
    {
        // 贴左边
        resultX = self.edgeOffsetX;
    }
    else
    {
        // 贴右边
        resultX = screenWidth - floatView.wf_width - self.edgeOffsetX;
    }
    
    // 计算resultY
    CGFloat resultY = floatView.wf_top;
    if (floatView.wf_top < self.edgeOffsetTop)
    {
        // 贴上边
        resultY = self.edgeOffsetTop;
    }
    else if (floatView.wf_top + floatView.wf_height > screenHeight - self.edgeOffsetBottom)
    {
        // 贴下边
        resultY = screenHeight - self.edgeOffsetBottom - floatView.frame.size.height;
    }
    
    //贴边
    [self.delegate cal_onMoveEndPoint:point willResultPoint:CGPointMake(resultX, resultY)];

}

- (void)touchesCancel:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(cal_onMoveCancel)])
    {
        [self.delegate cal_onMoveCancel];
    }
}
@end
