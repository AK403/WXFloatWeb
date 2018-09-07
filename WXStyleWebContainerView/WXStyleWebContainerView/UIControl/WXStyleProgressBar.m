//
//  WXStyleProgressBar.m
//  WXStyleWebView
//
//  Created by AK403 on 2018/9/3.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import "WXStyleProgressBar.h"
#import "UIView+WXStyle.h"

@interface WXStyleProgressBar()

@property (nonatomic, strong) UIView *progressView;

@end

@implementation WXStyleProgressBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.progressView];
    }
    return self;
}

- (void)layoutSubviews
{
    self.progressView.ws_height = self.ws_height;
}

- (void)start
{
    self.progressView.ws_width = 0;
    self.progressView.hidden = NO;
    [UIView animateWithDuration:5 animations:^{
        self.progressView.ws_width = self.ws_width * 0.7;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)end
{
    [UIView animateWithDuration:1 animations:^{
        self.progressView.ws_width = self.ws_width;
    } completion:^(BOOL finished) {
        self.progressView.hidden = YES;
    }];
}

#pragma mark - initlize getter
- (UIView *)progressView
{
    if (!_progressView)
    {
        _progressView = [[UIView alloc] init];
        _progressView.backgroundColor = [UIColor greenColor];
    }
    return _progressView;
}
@end
