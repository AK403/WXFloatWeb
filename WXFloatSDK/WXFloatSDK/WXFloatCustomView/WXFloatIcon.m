//
//  WXFloatIcon.m
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/23.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import "WXFloatIcon.h"
#import "WXFloatMoveCalculator.h"
#import "UIView+WXFloatUtil.h"
#import "WXFloatUtil.h"

@interface WXFloatIcon()

@property (nonatomic, assign) CGPoint startPosition;
@property (nonatomic, strong) UIVisualEffectView *effectView;


@end

@implementation WXFloatIcon

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.effectView];
        [self addSubview:self.imageView];
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = self.wf_width/2;
    
    self.effectView.frame = self.bounds;
    self.effectView.layer.cornerRadius = self.effectView.wf_width/2;
    
    self.imageView.wf_size = CGSizeMake(self.effectView.wf_width - 10 * 2, self.effectView.wf_height - 10 * 2);
    self.imageView.center = self.effectView.center;
    self.imageView.layer.cornerRadius = self.imageView.wf_width/2;
    self.imageView.layer.masksToBounds = YES;
}

#pragma mark - pubic method
+ (CGRect)floatIconFrame
{
    return CGRectMake(20, 100, 60, 60);
}

- (UIImage *)floatIconDefaultImage
{
    return WXFloat_Image(@"floatIcon.png");
}

#pragma mark - initlize getter
- (UIVisualEffectView *)effectView
{
    if (!_effectView)
    {
        _effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        _effectView.layer.masksToBounds = YES;
    }
    return _effectView;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] init];
        [_imageView setImage:[self floatIconDefaultImage]];
    }
    return _imageView;
}

@end
