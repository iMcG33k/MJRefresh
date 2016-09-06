//
//  MJExampleWindow.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/8/17.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJExampleWindow.h"
#import "MJTempViewController.h"

@implementation MJExampleWindow

static UIWindow* window_; // 为什么是window_, 而不是_window? 应该是为了区别成员变量.
+ (void)show
{
    window_ = [[UIWindow alloc] init];
    CGFloat width = 150;
    CGFloat x = [UIScreen mainScreen].bounds.size.width - width - 10;
    window_.frame = CGRectMake(x, 0, width, 25);
    window_.windowLevel = UIWindowLevelAlert; // 设置 window等级, 保证window在最前显示
    window_.hidden = NO;
    window_.alpha = 0.5;
    window_.rootViewController = [[MJTempViewController alloc] init];
    window_.backgroundColor = [UIColor clearColor];
}
@end
