//
//  MJTempViewController.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/9/22.
//  Copyright © 2015年 小码哥. All rights reserved.
//

// 右上角 示例1,2,3 controller

#import <UIKit/UIKit.h>

@interface MJTempViewController : UIViewController

+ (instancetype)sharedInstance;

@property (assign, nonatomic) UIStatusBarStyle statusBarStyle;
@property (assign, nonatomic) BOOL statusBarHidden;

@end
