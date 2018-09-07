//
//  WXFloatMinimizeCircleView.m
//  WXFloatSDK
//
//  Created by AK403 on 2018/8/29.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import "WXFloatMinimizeCircleView.h"
#import "UIView+WXFloatUtil.h"
#import "WXFloatUtil.h"

@interface WXFloatMinimizeCircleView()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIImageView *tipImageView;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UIBezierPath *smallBezierPath;
@property (nonatomic, strong) UIBezierPath *bigBezierPath;

@end

static CGFloat kSmallRadius = 160;
static CGFloat kBigRadius = 170;
static CGFloat kTouchRadius = 180;

@implementation WXFloatMinimizeCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.effectView];
        [self.contentView addSubview:self.tipLabel];
        [self.contentView addSubview:self.tipImageView];
        self.contentView.layer.mask = self.shapeLayer;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.wf_width == 0 || self.wf_height == 0)
    {
        return;
    }
    
    self.contentView.wf_size = self.wf_size;
    
    self.bigBezierPath =[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.contentView.wf_width, self.contentView.wf_height) radius:kBigRadius startAngle:0 endAngle:2*M_PI clockwise:YES];
    [self.bigBezierPath stroke];
    self.smallBezierPath =[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.contentView.wf_width, self.contentView.wf_height) radius:kSmallRadius startAngle:0 endAngle:2*M_PI clockwise:YES];
    [self.smallBezierPath stroke];
    
    self.effectView.frame = self.contentView.bounds;
    
    [self.tipLabel sizeToFit];
    self.tipLabel.wf_centerX = self.contentView.wf_width/2 + 20;
    self.tipLabel.wf_bottom = self.contentView.wf_height - 34;
    
    self.tipImageView.wf_size = CGSizeMake(40, 40);
    self.tipImageView.wf_bottom = self.tipLabel.wf_top - 8;
    self.tipImageView.wf_centerX = self.tipLabel.wf_centerX;
}

#pragma mark - public method
- (void)updateProgress:(CGFloat)progress
{
    self.shapeLayer.path = self.smallBezierPath.CGPath;
    [self.tipImageView setImage:[self miniMizeImage]];
    self.contentView.wf_left = self.contentView.wf_width * (1 - progress);
    self.contentView.wf_top = self.contentView.wf_height * (1 - progress);
}

- (void)configSelectedState
{
    [self updateProgress:1];
    [self.tipImageView setImage:[self miniMizeSelectedImage]];
    self.shapeLayer.path = self.bigBezierPath.CGPath;
}

- (BOOL)inMinizeCirclePoint:(CGPoint)point
{
    BOOL selected = NO;
    CGFloat circleX = self.superview.wf_width - point.x;
    CGFloat circleY = self.superview.wf_height - point.y;
    if (circleX * circleX + circleY * circleY < kTouchRadius * kTouchRadius)
    {
        selected = YES;
    }
    return selected;
}

+ (CGSize)minimizeCircleSize
{
    return CGSizeMake(kBigRadius, kBigRadius);
}

- (UIImage *)miniMizeImage
{
    UIImage *rubbishImage = WXFloat_Image(@"minimize.png");
    return rubbishImage;
}

- (UIImage *)miniMizeSelectedImage
{
    UIImage *rubbishImage = WXFloat_Image(@"minimize_selected.png");
    return rubbishImage;
}

#pragma mark - initlize getter
- (UIView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UIVisualEffectView *)effectView
{
    if (!_effectView)
    {
        _effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    }
    return _effectView;
}

- (UIImageView *)tipImageView
{
    if (!_tipImageView)
    {
        _tipImageView = [[UIImageView alloc] init];
    }
    return _tipImageView;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = [UIColor colorWithWhite:1 alpha:0.6];
        _tipLabel.font = [UIFont systemFontOfSize:12];
        [_tipLabel setText:@"浮窗"];
    }
    return _tipLabel;
}

- (CAShapeLayer *)shapeLayer
{
    if (!_shapeLayer)
    {
        _shapeLayer = [CAShapeLayer layer];
    }
    return _shapeLayer;
}
@end
