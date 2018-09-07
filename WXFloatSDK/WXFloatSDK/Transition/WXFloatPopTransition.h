//
//  WXFloatPopTransition.h
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/24.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WXFloatPopTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic, assign)BOOL isInteracting;
@property (nonatomic, weak) UIViewController* animatedTransitionRespondViewController;

@end
