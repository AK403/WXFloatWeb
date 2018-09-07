//
//  WXFloatMinimizeCircleView.h
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/29.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXFloatMinimizeCircleViewProtocol.h"

@interface WXFloatMinimizeCircleView : UIView<WXFloatMinimizeCircleViewProtocol>

- (UIImage *)miniMizeImage;

- (UIImage *)miniMizeSelectedImage;
@end
