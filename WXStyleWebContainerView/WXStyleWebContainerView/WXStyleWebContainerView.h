//
//  WXStyleWebContainerView.h
//  WXStyleWebView
//
//  Created by AK403 on 2018/9/3.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WXStyleWebContainerView : UIView

@property (nonatomic, strong) WKWebView *webView;

- (instancetype)initWithUrlRequest:(NSURLRequest *)request;

- (void)loadRequest:(NSURLRequest *)request;

@end
