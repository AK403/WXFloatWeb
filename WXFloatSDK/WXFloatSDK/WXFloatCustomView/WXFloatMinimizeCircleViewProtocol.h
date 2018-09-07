//
//  WXFloatMinimizeCircleViewProtocol.h
//  WXFloatSDK
//
//  Created by AK403 on 2018/9/2.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WXFloatMinimizeCircleViewProtocol <NSObject>

// contentview从右下角往上移动的控制速率
- (void)updateProgress:(CGFloat)progress;

// 当被选中时候的状态
- (void)configSelectedState;

- (BOOL)inMinizeCirclePoint:(CGPoint)point;

+ (CGSize)minimizeCircleSize;

@end
