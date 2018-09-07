//
//  WXFloatManager.m
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/23.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import "WXFloatManager.h"
#import "WXFloatWindow.h"
#import "WXFloatIconProtocol.h"
#import "WXFloatIcon.h"
#import "WXFloatMinimizeCircleViewProtocol.h"
#import "WXFloatMinimizeCircleView.h"
#import "WXFloatRubbishCircleViewProtocol.h"
#import "WXFloatRubbishCircleView.h"

@interface WXFloatManager()

@end

@implementation WXFloatManager

static WXFloatManager *_manager = nil;

+ (WXFloatManager *)sharedInstance
{    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil)
        {
            _manager = [[WXFloatManager alloc] init];
        }
    });
    return _manager;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.floatIconClass = [WXFloatIcon class];
        self.minimizeViewClass = [WXFloatMinimizeCircleView class];
        self.rubbishClass = [WXFloatRubbishCircleView class];
    }
    return self;
}

#pragma mark - pubic method

- (void)configFloatIcon:(Class<WXFloatIconProtocol>)floatIconClass
{
    if ([floatIconClass conformsToProtocol:@protocol(WXFloatIconProtocol)]
        && [floatIconClass isKindOfClass:[UIView class]])
    {
        return;
    }
    NSAssert(false, @"must conform WXFloatIconProtocol");
}


- (void)configMinimizeView:(Class<WXFloatMinimizeCircleViewProtocol>)minimizeViewClass
{
    if ([minimizeViewClass conformsToProtocol:@protocol(WXFloatMinimizeCircleViewProtocol)]
        && [minimizeViewClass isKindOfClass:[UIView class]])
    {
        return;
    }
    NSAssert(false, @"must conform WXFloatMinimizeCircleViewProtocol");
}

- (void)configRubbishCircleView:(Class<WXFloatRubbishCircleViewProtocol>)rubbishClass
{
    if ([rubbishClass conformsToProtocol:@protocol(WXFloatRubbishCircleViewProtocol)]
        && [rubbishClass isKindOfClass:[UIView class]])
    {
        return;
    }
    NSAssert(true, @"must conform WXFloatIconProtocol");
}

#pragma mark - initlize getter
- (WXFloatWindow *)floatWindow
{
    if (!_floatWindow)
    {
        [self setUp];
    }
    return _floatWindow;
}

- (void)setUp
{
    if (!_floatWindow)
    {
        _floatWindow = [[WXFloatWindow alloc]
                            initWithFrame:CGRectMake(0,
                                                     0,
                                                     [UIScreen mainScreen].bounds.size.width,
                                                     [UIScreen mainScreen].bounds.size.height)];
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [_floatWindow makeKeyAndVisible];
        [keyWindow makeKeyWindow];
    }
}

@end
