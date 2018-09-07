//
//  WXFloatTransitionDelegateObject.h
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/28.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WXFloatTransitionStyle){
    WXFloatTransitionStyleDefault = 0, //默认的页面推入退出
    WXFloatTransitionStyleMinimize = 1, //有缩放动画
};

@interface WXFloatTransitionObject : NSObject<UIViewControllerTransitioningDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *popBackInteractivePopGesture;

@property (nonatomic, weak) UIViewController *weakVC;

@property (nonatomic, assign) WXFloatTransitionStyle transtionStyle;

@end
