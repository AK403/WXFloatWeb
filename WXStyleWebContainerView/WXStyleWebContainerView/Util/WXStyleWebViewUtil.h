//
//  WXStyleWebViewUtil.h
//  WXStyleWebView
//
//  Created by AK403 on 2018/9/3.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define WXStyleWeb_SrcName(file)               [@"WXStyleWebContainerView.bundle" stringByAppendingPathComponent:file]
#define WXStyleWeb_FrameworkSrcName(file)      [@"WXStyleWebContainerView.framework/WXStyleWebView.bundle" stringByAppendingPathComponent:file]
#define WXStyleWeb_Image(file)                 [UIImage imageNamed:WXStyleWeb_SrcName(file)] ? :[UIImage imageNamed:WXStyleWeb_FrameworkSrcName(file)]

@interface WXStyleWebViewUtil : NSObject

+ (BOOL)isPhoneX;

+ (CGFloat)bottomTabbarHeight;
@end
