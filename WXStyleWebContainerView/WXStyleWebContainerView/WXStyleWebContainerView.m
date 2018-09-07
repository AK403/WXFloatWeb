//
//  WXStyleWebContainerView.m
//  WXStyleWebView
//
//  Created by AK403 on 2018/9/3.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import "WXStyleWebContainerView.h"
#import "WXStyleProgressBar.h"
#import "WXStyleBottomBar.h"
#import "UIView+WXStyle.h"
#import "WXStyleWebViewUtil.h"
#import "UIColor+WXStyle.h"

@interface WXStyleWebContainerView()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) WXStyleProgressBar *progressBar;
@property (nonatomic, strong) WXStyleBottomBar *bottomBar;
@property (nonatomic, assign) BOOL handleScrolling;
@property (nonatomic, assign) CGFloat lastContentOffset;

@end

@implementation WXStyleWebContainerView

- (instancetype)initWithUrlRequest:(NSURLRequest *)request
{
    if (self = [self init])
    {
        [self loadRequest:request];
    }
    return self;
}

- (void)loadRequest:(NSURLRequest *)request
{
    [self.webView loadRequest:request];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.addressLabel];
        [self addSubview:self.webView];
        [self addSubview:self.progressBar];
        [self addSubview:self.bottomBar];
        
        [self addWebViewObservers];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (CGRectEqualToRect(frame, CGRectZero))
    {
        return;
    }
    
    [self.addressLabel sizeToFit];
    self.addressLabel.ws_width = self.ws_width;
    self.addressLabel.ws_top = 20;
    self.addressLabel.ws_left = 0;
    
    self.progressBar.ws_width = self.ws_width;
    self.progressBar.ws_height = 3;
    self.progressBar.ws_top = 0;
    self.progressBar.ws_left = 0;
    
    self.bottomBar.ws_width = self.ws_width;
    self.bottomBar.ws_height = [WXStyleWebViewUtil bottomTabbarHeight];
    
    [self autoRestWebContent];
}

- (void)dealloc
{
    [self removeWebViewObserver];
}

#pragma mark - observer
- (void)addWebViewObservers
{
    [self.webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeWebViewObserver
{
    [self.webView removeObserver:self forKeyPath:@"URL"];
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"URL"])
    {
        [self updateAddressLabel:change[NSKeyValueChangeNewKey]];
    }
    else if ([keyPath isEqualToString:@"canGoBack"])
    {
        BOOL canGoBack = [change[NSKeyValueChangeNewKey] boolValue];
        self.bottomBar.backButton.enabled = canGoBack;
        [self autoRestWebContent];
    }
    else if ([keyPath isEqualToString:@"canGoForward"])
    {
        BOOL canGoForward = [change[NSKeyValueChangeNewKey] boolValue];
        self.bottomBar.forwardButton.enabled = canGoForward;
        [self autoRestWebContent];
    }
}

#pragma mark - initlize getter
- (UILabel *)addressLabel
{
    if (!_addressLabel)
    {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = [UIFont systemFontOfSize:12];
        _addressLabel.textAlignment = NSTextAlignmentCenter;
        _addressLabel.alpha = 0;
        _addressLabel.textColor = [UIColor ws_colorWithHexString:@"#B5B5B5"];
    }
    return _addressLabel;
}

- (WKWebView *)webView
{
    if (!_webView)
    {
        _webView = [[WKWebView alloc] init];
        _webView.backgroundColor = [UIColor clearColor];
        _webView.scrollView.backgroundColor = [UIColor clearColor];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.delegate = self;
        _webView.clipsToBounds = NO;
        _webView.scrollView.clipsToBounds = NO;
        
        
        if (@available(iOS 9.0, *))
        {
            _webView.allowsLinkPreview = NO;
        }
        if (@available(iOS 11.0, *))
        {
            _webView.insetsLayoutMarginsFromSafeArea = NO;
        }
    }
    return _webView;
}

- (WXStyleProgressBar *)progressBar
{
    if (!_progressBar)
    {
        _progressBar = [[WXStyleProgressBar alloc] init];
    }
    return _progressBar;
}

- (WXStyleBottomBar *)bottomBar
{
    if (!_bottomBar)
    {
        __weak typeof(self) weakSelf = self;
        _bottomBar = [[WXStyleBottomBar alloc] init];
        [_bottomBar configBackAction:^{
            [weakSelf.webView goBack];
        }];
        
        [_bottomBar configForwardAction:^{
            [weakSelf.webView goForward];
        }];
    }
    return _bottomBar;
}

#pragma mark - WKUIDelegate && WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow+2);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    [self.progressBar start];
    [self autoRestWebContent];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    [self.progressBar end];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    [self.progressBar end];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    [self.progressBar end];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.webView.scrollView.backgroundColor = [UIColor clearColor];
    
    if ([self shouldShowBottomBar] || self.webView.scrollView.contentSize.height < self.ws_height * 1.5)
    {
        self.handleScrolling = YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffset = scrollView.contentOffset.y;
    
    // handle address label
    if (contentOffset < -50)
    {
        CGFloat alpha = -(contentOffset + 50)/120;
        alpha = MIN(1, alpha);
        self.addressLabel.alpha = alpha;
    }
    else
    {
        self.addressLabel.alpha = 0;
    }
    
    if (!self.handleScrolling || ![self shouldShowBottomBar] || self.webView.scrollView.contentSize.height < self.ws_height * 1.5 || contentOffset <0 || contentOffset + self.webView.ws_height > self.webView.scrollView.contentSize.height)
    {
        return;
    }
    
    CGFloat offset = contentOffset - self.lastContentOffset;
    [self updateContentByOffset:offset];
    
    self.lastContentOffset = contentOffset;
}

// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate == NO && self.handleScrolling)
    {
        [self adjustWebContentWhenStopScrolling];
        self.handleScrolling = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.handleScrolling)
    {
        [self adjustWebContentWhenStopScrolling];
    }
    else
    {
        self.handleScrolling = NO;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}

#pragma mark - private method
- (void)autoRestWebContent
{
    if ([self.webView canGoBack] || [self.webView canGoForward])
    {
        if (self.bottomBar.ws_bottom != self.ws_height)
        {
            [self resetFullWebContent];
        }
    }
    else
    {
        if (self.bottomBar.ws_top != self.ws_height)
        {
            [self resetEmptyBottomBarWebContent];
        }
    }
}

- (void)resetFullWebContent
{
    self.bottomBar.ws_bottom = self.ws_height;
    
    self.webView.ws_size = CGSizeMake(self.ws_width, self.ws_height - self.bottomBar.ws_height);
    self.webView.ws_bottom = self.ws_height - self.bottomBar.ws_height;
}

- (void)resetEmptyBottomBarWebContent
{
    self.webView.frame = self.bounds;
    self.bottomBar.ws_top = self.ws_height;
}

- (void)adjustWebContentWhenStopScrolling
{
    if (self.bottomBar.ws_top < (self.ws_height - self.bottomBar.ws_height/2))
    {
        [UIView animateWithDuration:0.1 animations:^{
            [self resetFullWebContent];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.1 animations:^{
            [self resetEmptyBottomBarWebContent];
        }];
    }
}

- (void)updateContentByOffset:(CGFloat)offset
{
    if (offset > 4)
    {
        offset = 4;
    }
    else if (offset < -4)
    {
        offset = -4;
    }
    
    self.bottomBar.ws_top += offset;
    if (self.bottomBar.ws_top >= self.ws_height)
    {
        self.bottomBar.ws_top = self.ws_height;
        self.webView.ws_height = self.ws_height;
    }
    else if (self.bottomBar.ws_bottom <= self.ws_height)
    {
        self.bottomBar.ws_bottom = self.ws_height;
        self.webView.ws_height = self.ws_height - self.bottomBar.ws_height;
    }
}

- (BOOL)shouldShowBottomBar
{
    if (self.webView.canGoBack || self.webView.canGoForward)
    {
        return YES;
    }
    return NO;
}

- (void)updateAddressLabel:(NSURL *)URL
{
    if ([URL isKindOfClass:[NSURL class]])
    {
        self.addressLabel.text = [NSString stringWithFormat:@"此网址由%@提供",URL.host];
    }
}
@end
