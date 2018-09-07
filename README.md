## 1 介绍
仿微信，带有浮窗能力的微信浏览器

项目一共分为三个工程

* 1 WXFloatSDK ： 仿微信的浮窗功能
* 2 WXStyleWebContainerView ： 仿微信的webeview页面(进度条，底部导航栏，背景地址)
>上面两个库是不耦合的，可以拼装成具有浮窗功能的H5，也可以单独使用,具体可以参考Demo中的WXStyleWebViewController如何使用以上两个库。如果想直接使用Demo中的WXStyleWebViewController，可以直接pod以下命令 


* 3 WXFloatWebDemo :demo中的WXStyleWebViewController，依赖到第一和第二个工程，如果想直接使用可以拖入工程使用或者修改，

<img src="demo.GIF" width=375 height= 812 />

## 2 WXFloatSDK (浮窗)使用

### 2.1 调用

```
#import <UIViewController+WXFloat.h>

UIViewController *viewController = [[UIViewController alloc] init];
UINavigationController *navi = [[UINavigationController alloc]
                                initWithRootViewController: viewController];
[viewController wf_presentSelfAnimated:YES 
                                  navi:navi 
                            completion:^{
    
} presentingViewController:self];

//
其他方法可以参考UIViewController+WXFloat
    
```




### 2.2 自定义view
> 浮窗Icon， pop页面时右下角的circleView以及移动浮窗Icon出现的垃圾桶view，支持自定义.

* 浮窗icon: 可继承WXFloatIcon 或者 实现WXFloatIconProtocol 协议
* pop页面右下角的view: 继承WXFloatMinimizeCircleView 或者实现WXFloatMinimizeCircleViewProtocol协议
* 移动浮窗出现的垃圾桶: 继承WXFloatRubbishCircleView 或者实现
WXFloatRubbishCircleViewProtocol协议

> 在第一步调用前，需将自定义view的class赋予manager的属性

```

.....
[WXFloatManager sharedInstance].floatIconClass = [NewFloatIcon class];
[WXFloatManager sharedInstance].minimizeViewClass = [NewMinimizeView class];
[WXFloatManager sharedInstance].rubbishClass = [NewRubisshView class];

以上调用需在以下函数之前调用
[UIViewController wf_presentSelfAnimated: navi: completion: presentingViewController]
...


```

## 3 WXStylWebContanierView使用(微信样式的webview)

### 3.1 调用
```
- (void)viewDidLoad
{
      ....
      WXStyleContainerView *containerView = [[WXStyleContainerView alloc] initWithUrlRequest:request];
      containerView.frame = CGRectMake(0,navigationBarHeight,screenWidth,screenHeight - navigationBarHeight);
      
      [self.view addSubView containerView];
}

```


## 4 WXFloatWebDemo
里面可以使用的是WXStyleWebViewController，可以将整个文件夹拖入工程使用

```
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WebModel *model = self.webModelArray[indexPath.row];
    [WXStyleWebViewController presentSelfWithUrlStr:model.urlStr presentingViewController:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

```

## 5 安装

### 5.1 CocoaPod安装方式
* 1 WXFloatSDK（浮窗）

```
pod WXFloatWeb/WXFloatSDK
```

* 2 WXStyleWebContainerView （微信WebView）

```
pod WXFloatWeb/WXStyleWebContainerView
```

* 3 WXFloatWebDemo（Demo中的WXStyleWebViewController）

```
pod WXFloatWeb/WXStyleWebViewController   
//依赖到上面两个库，会同时引入，相当于pod 1+2+3
```

* 4 WXFloatWeb 

```
pod WXFloatWeb
// 相当于pod 1+2
```

### 5.2 可以直接拖入工程使用

* 直接拖入文件的方式，注意将资源文件拖入
* 如果是拖入子工程的方式，注意资源文件 bundle需要拷贝到主target中

## 6 Licenses

[MIT License](./LICENSE)


## 7 作者
* 微信号 liuyumxuan2
* 手机 13660271169
