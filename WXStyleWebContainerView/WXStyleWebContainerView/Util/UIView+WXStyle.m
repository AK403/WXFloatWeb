//
//  UIView+WXStyle.m
//  WXStyleWebView
//
//  Created by AK403 on 2018/9/3.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import "UIView+WXStyle.h"

@implementation UIView (WXStyle)


- (CGFloat)ws_width
{
    return self.frame.size.width;
}

- (void)setWs_width:(CGFloat)ws_width
{
    CGRect rect = self.frame;
    rect.size.width = ws_width;
    self.frame = rect;
}

- (CGFloat)ws_height
{
    return self.frame.size.height;
}

- (void)setWs_height:(CGFloat)ws_height
{
    CGRect rect = self.frame;
    rect.size.height = ws_height;
    self.frame = rect;
}

- (CGPoint)ws_point
{
    return self.frame.origin;
}

- (void)setWs_point:(CGPoint)ws_point
{
    CGRect rect = self.frame;
    rect.origin = ws_point;
    self.frame = rect;
}

- (CGSize)ws_size
{
    return self.frame.size;
}

- (void)setWs_size:(CGSize)ws_size
{
    CGRect rect = self.frame;
    rect.size = ws_size;
    self.frame = rect;
}

- (CGFloat)ws_top
{
    return self.frame.origin.y;
}

- (void)setWs_top:(CGFloat)ws_top
{
    CGRect rect = self.frame;
    rect.origin.y = ws_top;
    self.frame = rect;
}

- (CGFloat)ws_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setWs_bottom:(CGFloat)ws_bottom
{
    CGRect rect = self.frame;
    rect.origin.y = ws_bottom - rect.size.height;
    self.frame = rect;
}

- (CGFloat)ws_left
{
    return self.frame.origin.x;
}

- (void)setWs_left:(CGFloat)ws_left
{
    CGRect rect = self.frame;
    rect.origin.x = ws_left;
    self.frame = rect;
}

- (CGFloat)ws_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setWs_right:(CGFloat)ws_right
{
    CGRect rect = self.frame;
    rect.origin.x = ws_right - rect.size.width;
    self.frame = rect;
}

- (CGFloat)ws_centerX
{
    return self.center.x;
}

- (void)setWs_centerX:(CGFloat)ws_centerX
{
    CGPoint point = self.center;
    point.x = ws_centerX;
    self.center = point;
}

- (CGFloat)ws_centerY
{
    return self.center.y;
}

- (void)setWs_centerY:(CGFloat)ws_centerY
{
    CGPoint point = self.center;
    point.y = ws_centerY;
    self.center = point;
}

@end
