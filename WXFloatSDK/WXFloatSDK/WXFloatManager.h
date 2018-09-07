//
//  WXFloatManager.h
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/23.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXFloatWindow.h"
#import "WXFloatIconProtocol.h"
#import "WXFloatRubbishCircleViewProtocol.h"
#import "WXFloatMinimizeCircleViewProtocol.h"

@interface WXFloatManager : NSObject

@property (nonatomic, strong) WXFloatWindow *floatWindow;
@property (nonatomic, strong) Class<WXFloatIconProtocol>floatIconClass;
@property (nonatomic, strong) Class<WXFloatMinimizeCircleViewProtocol>minimizeViewClass;
@property (nonatomic, strong) Class<WXFloatRubbishCircleViewProtocol>rubbishClass;

+ (WXFloatManager *)sharedInstance;

- (void)setUp;

@end
