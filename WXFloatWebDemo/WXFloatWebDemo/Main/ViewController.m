//
//  ViewController.m
//  WXFloatWebDemo
//
//  Created by AK403 on 2018/9/7.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import "ViewController.h"
#import "WXStyleWebViewController.h"

@interface WebModel:NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *urlStr;

@end

@implementation WebModel

- (instancetype)initWithTitle:(NSString *)title urlStr:(NSString *)urlStr
{
    if (self = [self init])
    {
        self.title = title;
        self.urlStr = urlStr;
    }
    return self;
}

@end

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *webModelArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

#pragma mark - initlize getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.webModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIdentifier = @"kCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    WebModel *model = self.webModelArray[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WebModel *model = self.webModelArray[indexPath.row];
    
    [WXStyleWebViewController presentSelfWithUrlStr:model.urlStr presentingViewController:self];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - initlize getter
- (NSArray *)webModelArray
{
    if (!_webModelArray)
    {
        _webModelArray = @[
                           [[WebModel alloc] initWithTitle:@"腾讯网" urlStr:@"https://qq.com"],
                           [[WebModel alloc] initWithTitle:@"淘宝网" urlStr:@"https://taobao.com"],
                           [[WebModel alloc] initWithTitle:@"新浪网" urlStr:@"https://sina.com"],
                           [[WebModel alloc] initWithTitle:@"雅虎" urlStr:@"https://yahoo.com"],
                           [[WebModel alloc] initWithTitle:@"百度" urlStr:@"https://baidu.com"],
                           [[WebModel alloc] initWithTitle:@"网易" urlStr:@"https://163.com"],
                           [[WebModel alloc] initWithTitle:@"苹果" urlStr:@"https://apple.com"],
                           [[WebModel alloc] initWithTitle:@"4399" urlStr:@"https://4399.com"],
                           [[WebModel alloc] initWithTitle:@"当当网" urlStr:@"http://www.dangdang.com"],
                           ];
    }
    return _webModelArray;
}

@end
