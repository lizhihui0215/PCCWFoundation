//
//  PCCWTableViewController.h
//  PCCWFoundation
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "PCCWViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <FDTemplateLayoutCell/FDTemplateLayoutCell.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PCCWTableViewControllerDelegate <NSObject>

- (MJRefreshStateHeader *)defaultRefreshHeader;

- (MJRefreshBackStateFooter *)defaultRefreshFooter;

@optional
- (void)tableView:(UITableView *)tableView footerBeginRefresh:(MJRefreshBackStateFooter *)footer;

- (void)tableView:(UITableView *)tableView headerBeginRefresh:(MJRefreshStateHeader *)header;

@end

@interface PCCWTableViewController : PCCWViewController<PCCWTableViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutletCollection(UITableView) NSArray *tableViews;

@property (nonatomic, readonly) UITableView *tableView;

@property (nonatomic, assign, getter=isHeaderRefresh) BOOL headerRefresh;

@property (nonatomic, assign, getter=isFotterRefresh) BOOL footerRefresh;

@end

NS_ASSUME_NONNULL_END
