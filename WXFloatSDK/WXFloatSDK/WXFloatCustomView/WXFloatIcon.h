//
//  WXFloatIcon.h
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/23.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXFloatMoveCalculator.h"
#import "WXFloatIconProtocol.h"
@interface WXFloatIcon : UIView<WXFloatIconProtocol>

@property (nonatomic, strong) UIImageView *imageView;

- (UIImage *)floatIconDefaultImage;
@end
