//
//  WXStyleWebViewController.h
//  WXStyleWebViewController
//
//  Created by AK403 on 2018/9/4.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXStyleWebViewController : UIViewController

+ (WXStyleWebViewController *)presentSelfWithUrlStr:(NSString *)urlStr presentingViewController:(UIViewController *)viewController;

+ (WXStyleWebViewController *)presentSelfWithRequest:(NSURLRequest *)request presentingViewController:(UIViewController *)viewController;


//点击右上角按钮，可以重写该方法
- (void)moreDidClicked;
@end
