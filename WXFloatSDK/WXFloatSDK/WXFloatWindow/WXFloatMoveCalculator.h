//
//  WXFloatMoveCalculator.h
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/23.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol WXFloatMoveCalculatorDelegate<NSObject>

@optional
- (void)cal_didTap; //点击了页面
- (void)cal_onTouchBeginPoint:(CGPoint)point; //手指刚开始接触的点

@required
- (void)cal_onMovingPoint:(CGPoint)point;  // 手指拖拽过程,做过处理，只有移动一定距离才会回调
- (void)cal_onMoveEndPoint:(CGPoint)currentPoint
           willResultPoint:(CGPoint)resultPoint; // 拖拽结束时当前点的位置，以及即将移动到的位置

- (void)cal_onMoveCancel;

@end

@interface WXFloatMoveCalculator : NSObject

@property (nonatomic, weak) id <WXFloatMoveCalculatorDelegate> delegate;
@property (nonatomic, weak) UIView *moveingView;
@property (nonatomic, assign) CGFloat edgeOffsetX;
@property (nonatomic, assign) CGFloat edgeOffsetTop;
@property (nonatomic, assign) CGFloat edgeOffsetBottom;

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancel:(NSSet *)touches withEvent:(UIEvent *)event;

@end
