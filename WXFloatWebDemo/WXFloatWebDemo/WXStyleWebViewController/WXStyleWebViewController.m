//
//  WXStyleWebViewController.m
//  WXStyleWebViewController
//
//  Created by AK403 on 2018/9/4.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import "WXStyleWebViewController.h"
#import <WXStyleWebContainerView.h>
#import <UIView+WXStyle.h>
#import <UIColor+WXStyle.h>
#import <UIViewController+WXFloat.h>
#import <WXFloatManager.h>

#define WXStyleWebController_SrcName(file)               [@"WXStyleWebViewController.bundle" stringByAppendingPathComponent:file]
#define WXStyleWebController_FrameworkSrcName(file)      [@"WXStyleWebViewController.framework/WXStyleWebViewController.bundle" stringByAppendingPathComponent:file]
#define WXStyleWebController_Image(file)                 [UIImage imageNamed:WXStyleWebController_SrcName(file)] ? :[UIImage imageNamed:WXStyleWebController_FrameworkSrcName(file)]

@interface WXStyleWebViewController ()<UIActionSheetDelegate>

//@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) WXStyleWebContainerView *webContainerView;
@property (nonatomic, strong) NSURLRequest *request;
@end

@implementation WXStyleWebViewController

+ (WXStyleWebViewController *)presentSelfWithUrlStr:(NSString *)urlStr presentingViewController:(UIViewController *)viewController
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    return [self presentSelfWithRequest:request presentingViewController:viewController];
}

+ (WXStyleWebViewController *)presentSelfWithRequest:(NSURLRequest *)request presentingViewController:(UIViewController *)viewController
{
    WXStyleWebViewController *styleVC = [[WXStyleWebViewController alloc] initWithRequest:request];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:styleVC];
    
    [styleVC wf_presentSelfAnimated:YES navi:navi completion:^{
        
    } presentingViewController:viewController];
    
    return styleVC;
}

- (instancetype)initWithRequest:(NSURLRequest *)request
{
    if (self = [super init])
    {
        self.request = request;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:249 green:249 blue:249 alpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:249 green:249 blue:249 alpha:1];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:WXStyleWebController_Image(@"close.png") forState:UIControlStateNormal];
    closeButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    closeButton.imageEdgeInsets = UIEdgeInsetsMake(10, -15, 10, 15);
    [closeButton addTarget:self action:@selector(backDidClicked) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setImage:WXStyleWebController_Image(@"more.png") forState:UIControlStateNormal];
    moreButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    moreButton.imageEdgeInsets = UIEdgeInsetsMake(10, 15, 10, -15);
    [moreButton addTarget:self action:@selector(moreDidClicked) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreButton];
    
    [self.view addSubview:self.webContainerView];
    self.webContainerView.ws_top = self.navigationController.navigationBar.ws_bottom + [UIApplication sharedApplication].statusBarFrame.size.height;
    self.webContainerView.ws_width = self.view.ws_width;
    self.webContainerView.ws_height = self.view.ws_height - self.webContainerView.ws_top;
    [self.webContainerView.webView.scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.transitionObject.popBackInteractivePopGesture];
    
    
    __weak typeof(self) weakSelf = self;
    [self wf_configMimimizeAction:^{
        
        WXFloatManager *manager = [WXFloatManager sharedInstance];
        WXFloatWindow *floatWindow = manager.floatWindow;
        WXFloatIcon *floatIcon = (WXFloatIcon *)floatWindow.floatIcon;
        
//        if ([floatIcon.imageView respondsToSelector:@selector(sd_setImageWithURL:)])
//        {
            NSURL *URL = weakSelf.webContainerView.webView.URL;
            if(URL){
                NSString *scheme = URL.scheme;
                NSString *host = URL.host;
                
                NSString *imageUrlStr = [NSString stringWithFormat:@"%@://%@/favicon.ico",scheme,host];
                NSURL *imageURL = [NSURL URLWithString:imageUrlStr];
                
                [floatIcon.imageView performSelector:@selector(sd_setImageWithURL:) withObject:imageURL];
//                [floatIcon.imageView sd_setImageWithURL:imageURL];
            }

//        }
    }];
}

- (void)backDidClicked
{
    [self wf_dismissSelfAnimated:YES completion:nil];
}

- (void)moreDidClicked
{
//    [self wf_minimizeSelf];
    
    UIActionSheet *actionsheet = nil;
    if ([self wf_isFloating])
    {
        actionsheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"取消浮窗" otherButtonTitles:nil];

    }
    else
    {
        actionsheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"浮窗" otherButtonTitles:nil];
    }
    [actionsheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"取消浮窗"])
    {
        [self wf_cancelFloating];
    }
    else if([buttonTitle isEqualToString:@"浮窗"])
    {
        [self wf_minimizeSelf];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)viewDidAppear:(BOOL)animated
{
    
}

#pragma mark - initlize getter
- (WXStyleWebContainerView *)webContainerView
{
    if (!_webContainerView)
    {
        _webContainerView = [[WXStyleWebContainerView alloc] initWithUrlRequest:self.request];
    }
    return _webContainerView;
}

@end
