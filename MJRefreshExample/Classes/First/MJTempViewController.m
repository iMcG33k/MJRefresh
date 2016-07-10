//
//  MJTempViewController.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/9/22.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJTempViewController.h"

@interface MJTempViewController ()

@end

@implementation MJTempViewController
#pragma mark - 单例
static id instance_;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[self alloc] init];
    });
    return instance_;
}

+ (instancetype)allocWithZone:(struct _NSZone*)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [super allocWithZone:zone];
    });
    return instance_;
}

#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.statusBarStyle = UIStatusBarStyleLightContent;

    self.view.backgroundColor = [UIColor clearColor];

    UISegmentedControl* control = [[UISegmentedControl alloc]
        initWithItems:@[ @"示例1", @"示例2", @"示例3" ]];
    control.tintColor = [UIColor orangeColor];
    control.frame = self.view.bounds;
    control.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    control.selectedSegmentIndex = 0;
    [control addTarget:self action:@selector(contorlSelect:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:control];
}

- (void)contorlSelect:(UISegmentedControl*)control
{
    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow; // 获取当前应用的keyWindow,并不是
    keyWindow.rootViewController = [keyWindow.rootViewController.storyboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%zd", control.selectedSegmentIndex]]; // 通过 main.storyboard 创建当前选中的控制器, 设置到 keyWindow 的 rootVc

    //MARK: 技巧: 通过 属性传递 状态栏设置信息, 比 通过属性传递 selectedSegmentIndex 更简洁
    if (control.selectedSegmentIndex == 0) { // 根据选中Vc 切换状态栏颜色/状态
        self.statusBarStyle = UIStatusBarStyleLightContent;
        self.statusBarHidden = NO;
    }
    else if (control.selectedSegmentIndex == 1) {
        self.statusBarHidden = YES;
    }
    else if (control.selectedSegmentIndex == 2) {
        self.statusBarStyle = UIStatusBarStyleDefault;
        self.statusBarHidden = NO;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.statusBarStyle;
}

- (BOOL)prefersStatusBarHidden
{
    return self.statusBarHidden;
}

- (void)setStatusBarHidden:(BOOL)statusBarHidden
{
    _statusBarHidden = statusBarHidden;

    [self setNeedsStatusBarAppearanceUpdate]; //MARK: 更新 状态栏 显示
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    _statusBarStyle = statusBarStyle;

    [self setNeedsStatusBarAppearanceUpdate];
}

@end
