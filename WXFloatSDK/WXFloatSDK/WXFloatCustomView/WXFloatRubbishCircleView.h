//
//  WXFloatRubbishCircleView.h
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/29.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXFloatRubbishCircleViewProtocol.h"

@interface WXFloatRubbishCircleView : UIView<WXFloatRubbishCircleViewProtocol>

- (UIImage *)rubbishCircleImage;

- (UIImage *)rubbishSelectedCircleImage;
@end
