//
//  MJSingleViewController.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJRefresh.h"
#import "MJSingleViewController.h"
#import "MJTestViewController.h"

@interface MJSingleViewController ()
@property (assign, nonatomic) int count;
@end

@implementation MJSingleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.count = 0;

    __unsafe_unretained typeof(self) weakSelf = self;
    __unsafe_unretained UITableView* tableView = self.tableView; //???: why __unsafe_unretained tableView

    // 通过 MJRefresh 的 ScrollView分类 添加 MJRefreshNormalHeader
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{ //MARK: 在这个block 中 完成 1数据请求, 2刷新显示(table reloadData), 3mj_header endRefreshing
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.count += 12;
            [tableView reloadData];
            [tableView.mj_header endRefreshing];
        });
    }];
    tableView.mj_header.automaticallyChangeAlpha = YES; // 开启 根据 拖拽比例 设置透明度

    MJRefreshAutoNormalFooter* footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.count += 5;
            [tableView reloadData];
            [tableView.mj_footer endRefreshing];
        });
    }];
    footer.hidden = YES; // 是否 启用 上拉下拉刷新功能, 设置 hidden属性就可以了
    tableView.mj_footer = footer;
}

- (NSInteger)tableView:(nonnull UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    //MARK: 旧 cell复用方式
    static NSString* ID = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row % 2 && self.navigationController) { // 有 Nav 才可以 push
        cell.textLabel.text = @"push";
    }
    else {
        cell.textLabel.text = @"modal";
    }
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    MJTestViewController* test = [[MJTestViewController alloc] init];
    if (indexPath.row % 2 && self.navigationController) {
        test.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:test animated:YES];
    }
    else {
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:test];
        [self presentViewController:nav animated:YES completion:nil];
    }
}
@end
