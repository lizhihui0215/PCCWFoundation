//
//  PCCWTableViewController.m
//  PCCWFoundation
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "PCCWTableViewController.h"

@interface PCCWTableViewController ()
@property (nonatomic, weak) id<PCCWTableViewControllerDelegate> tableViewDelegate;
@end

@implementation PCCWTableViewController

- (UITableView *)tableView{
    return self.tableViews[0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableViewDelegate = self;
    self.headerRefresh = NO;
    self.footerRefresh = NO;
    for (UITableView *tableView in self.tableViews) {
        
        if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [tableView setSeparatorInset: UIEdgeInsetsZero];
        }
        if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [tableView setLayoutMargins: UIEdgeInsetsZero];
        }
    }
    
    [self removeTableFooterView];
}

- (MJRefreshStateHeader *)defaultRefreshHeader {
    return [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableViewHeaderWillRefresh:)];
}

- (MJRefreshBackStateFooter *)defaultRefreshFooter{
    return [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(tableViewFooterWillRefresh:)];
}

- (void)setHeaderRefresh:(BOOL)headerRefresh{
    _headerRefresh = headerRefresh;
    for (UITableView *tableView in self.tableViews) {
        tableView.mj_header = _headerRefresh ? [self defaultRefreshHeader] : nil;
    }
}

- (void)setFooterRefresh:(BOOL)footerRefresh {
    _footerRefresh = footerRefresh;
    for (UITableView *tableView in self.tableViews) {
        tableView.mj_footer = _footerRefresh ? [self defaultRefreshFooter] : nil;
    }
}

- (void)tableViewFooterWillRefresh:(MJRefreshBackNormalFooter *)footer{
    UITableView *theTableView = nil;
    for (UITableView *tableView in self.tableViews) {
        if (tableView.mj_footer == footer){
            theTableView = tableView;
            break;
        }
    }
    
    if ([self.tableViewDelegate respondsToSelector:@selector(tableView:footerBeginRefresh:)]) {
        [self.tableViewDelegate tableView:theTableView footerBeginRefresh:footer];
    }
}

- (void)tableViewHeaderWillRefresh:(MJRefreshNormalHeader *)header{
    UITableView *theTableView = nil;
    for (UITableView *tableView in self.tableViews) {
        if (tableView.mj_header == header){
            theTableView = tableView;
            break;
        }
    }
    
    if ([self.tableViewDelegate respondsToSelector:@selector(tableView:headerBeginRefresh:)]) {
        [self.tableViewDelegate tableView:theTableView headerBeginRefresh:header];
    }
}

- (void)removeTableFooterView {
    for (UITableView *tableView in self.tableViews) {
        UIView *view = [[UIView alloc] init];
        
        view.backgroundColor = [UIColor whiteColor];
        
        tableView.tableFooterView = view;
    }
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
