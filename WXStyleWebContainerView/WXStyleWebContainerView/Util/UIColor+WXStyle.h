//
//  UIColor+WXStyle.h
//  WXStyleWebView
//
//  Created by AK403 on 2018/9/3.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WXStyle)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) ws_colorWithHexString: (NSString *)color;

@end
