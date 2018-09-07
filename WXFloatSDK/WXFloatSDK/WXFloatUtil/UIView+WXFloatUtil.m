//
//  UIView+WXFloatUtil.m
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/29.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import "UIView+WXFloatUtil.h"

@implementation UIView (WXFloatUtil)

- (CGFloat)wf_width
{
    return self.frame.size.width;
}

- (void)setWf_width:(CGFloat)wf_width
{
    CGRect rect = self.frame;
    rect.size.width = wf_width;
    self.frame = rect;
}

- (CGFloat)wf_height
{
    return self.frame.size.height;
}

- (void)setWf_height:(CGFloat)wf_height
{
    CGRect rect = self.frame;
    rect.size.height = wf_height;
    self.frame = rect;
}

- (CGPoint)wf_point
{
    return self.frame.origin;
}

- (void)setWf_point:(CGPoint)wf_point
{
    CGRect rect = self.frame;
    rect.origin = wf_point;
    self.frame = rect;
}

- (CGSize)wf_size
{
    return self.frame.size;
}

- (void)setWf_size:(CGSize)wf_size
{
    CGRect rect = self.frame;
    rect.size = wf_size;
    self.frame = rect;
}

- (CGFloat)wf_top
{
    return self.frame.origin.y;
}

- (void)setWf_top:(CGFloat)wf_top
{
    CGRect rect = self.frame;
    rect.origin.y = wf_top;
    self.frame = rect;
}

- (CGFloat)wf_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setWf_bottom:(CGFloat)wf_bottom
{
    CGRect rect = self.frame;
    rect.origin.y = wf_bottom - rect.size.height;
    self.frame = rect;
}

- (CGFloat)wf_left
{
    return self.frame.origin.x;
}

- (void)setWf_left:(CGFloat)wf_left
{
    CGRect rect = self.frame;
    rect.origin.x = wf_left;
    self.frame = rect;
}

- (CGFloat)wf_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setWf_right:(CGFloat)wf_right
{
    CGRect rect = self.frame;
    rect.origin.x = wf_right - rect.size.width;
    self.frame = rect;
}

- (CGFloat)wf_centerX
{
    return self.center.x;
}

- (void)setWf_centerX:(CGFloat)wf_centerX
{
    CGPoint point = self.center;
    point.x = wf_centerX;
    self.center = point;
}

- (CGFloat)wf_centerY
{
    return self.center.y;
}

- (void)setWf_centerY:(CGFloat)wf_centerY
{
    CGPoint point = self.center;
    point.y = wf_centerY;
    self.center = point;
}
@end
