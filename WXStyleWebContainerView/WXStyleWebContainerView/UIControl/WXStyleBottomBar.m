//
//  WXStyleBottomBar.m
//  WXStyleWebView
//
//  Created by AK403 on 2018/9/3.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import "WXStyleBottomBar.h"
#import "UIView+WXStyle.h"
#import "WXStyleWebViewUtil.h"
#import "UIColor+WXStyle.h"

@interface WXStyleBottomBar()

@property (nonatomic, strong) dispatch_block_t backAction;
@property (nonatomic, strong) dispatch_block_t forwardAction;

@end

@implementation WXStyleBottomBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.backButton];
        [self addSubview:self.forwardButton];
        self.backgroundColor = [UIColor ws_colorWithHexString:@"#f8f8f8"];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backButton.ws_size = CGSizeMake(40, 40);
    self.backButton.ws_right = self.ws_width/2 - 20;
    self.backButton.ws_top = 10;
    
    self.forwardButton.ws_size = CGSizeMake(40, 40);
    self.forwardButton.ws_left = self.ws_width/2 + 20;
    self.forwardButton.ws_top = 10;
}

#pragma mark - initlize getter
-(UIButton *)backButton
{
    if (!_backButton)
    {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[self backButtonImage] forState:UIControlStateNormal];
        [_backButton setImage:[self backButtonDisableImage] forState:UIControlStateDisabled];
        [_backButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [_backButton setEnabled:NO];
        [_backButton addTarget:self action:@selector(backButtonDidClicked) forControlEvents:UIControlEventTouchDown];
    }
    return _backButton;
}

- (UIButton *)forwardButton
{
    if (!_forwardButton)
    {
        _forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forwardButton setImage:[self forwardButtonImage] forState:UIControlStateNormal];
        [_forwardButton setImage:[self forwardButtonDisableImage] forState:UIControlStateDisabled];
        [_forwardButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [_forwardButton setEnabled:NO];
        [_forwardButton addTarget:self action:@selector(forwardButtonDidClicked) forControlEvents:UIControlEventTouchDown];
    }
    return _forwardButton;
}

- (void)configBackAction:(dispatch_block_t)backAction
{
    self.backAction = backAction;
}

- (void)configForwardAction:(dispatch_block_t)forwardAction
{
    self.forwardAction = forwardAction;
}

#pragma mark - event
- (void)backButtonDidClicked
{
    if (self.backAction)
    {
        self.backAction();
    }
}

- (void)forwardButtonDidClicked
{
    if (self.forwardAction)
    {
        self.forwardAction();
    }
}

#pragma mark - pubic method can override
- (UIImage *)backButtonImage
{
    return WXStyleWeb_Image(@"back.png");
}

- (UIImage *)backButtonDisableImage
{
    return WXStyleWeb_Image(@"back_disabled.png");
}

- (UIImage *)forwardButtonImage
{
    return WXStyleWeb_Image(@"forward.png");
}

- (UIImage *)forwardButtonDisableImage
{
    return WXStyleWeb_Image(@"forward_disabled.png");
}
@end
