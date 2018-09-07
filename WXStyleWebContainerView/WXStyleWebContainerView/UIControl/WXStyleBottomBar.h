//
//  WXStyleBottomBar.h
//  WXStyleWebView
//
//  Created by AK403 on 2018/9/3.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXStyleBottomBar : UIView

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *forwardButton;

- (void)configBackAction:(dispatch_block_t)backAction;

- (void)configForwardAction:(dispatch_block_t)forwardAction;

@end
