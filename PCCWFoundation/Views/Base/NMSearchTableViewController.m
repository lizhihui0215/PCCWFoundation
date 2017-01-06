//
//  NMSearchTableViewController.m
//  NM
//
//  Created by 李智慧 on 04/11/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import "NMSearchTableViewController.h"
#import "NMSearchTableViewCell.h"


@interface NMSearchTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *searchIconImageView;
@property (weak, nonatomic) IBOutlet UITextField *conditionTextField;
@property (weak, nonatomic) IBOutlet UILabel *searchTitleLabel;

@end

@implementation NMSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.headerRefresh = YES;
    self.footerRefresh = YES;
    
    self.iconImageView.image = [self.viewModel searchIconImage];
    self.searchTitleLabel.text = [self.viewModel searchTitle];
    self.title = [self.viewModel title];
    
    [self fetchWithCondition:self.conditionTextField.text
                   isRefresh:YES
             completeHandler:^(NSError *error) {
    }];
    @weakify(self)
    [self.conditionTextField setDidEndEditingBlock:^(UITextField *textField) {
        @strongify(self)
        [self fetchWithCondition:textField.text isRefresh:YES completeHandler:^(NSError *error) {
        }];
    }];
}

- (void)fetchWithCondition:(NSString *)condition isRefresh:(BOOL)isRefresh completeHandler:(NMViewModelCompleteHandler)handler {
    [self showHUDWithMessage:@""];
    [self.viewModel fetchWithCondition:self.conditionTextField.text
                             isRefresh:isRefresh
                       completeHandler:^(NSError *_Nullable error) {
                           [self hidHUD];
                           if (![self showAlertWithError:error]) {
                               [self.tableView reloadData];
                           }
                           handler(error);
                       }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel numberOfRowsInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)sectionIndex{
    NMSection *section = [self.viewModel sectionAt:sectionIndex];
    return [NSString stringWithFormat:@"   %@",section.sectionIndex.firstLetter];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    NMSection *section = [self.viewModel sectionAt:index];
    return section.sectionIndex.index;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray <NSString *>* titles = [NSMutableArray array];
    
    for (NMSection *section in self.viewModel.dataSource) {
        [titles addObject:[section sectionIndex].firstLetter];
    }
    
    return titles;
}

- (void)tableView:(UITableView *)tableView footerBeginRefresh:(MJRefreshBackStateFooter *)footer{
    [self fetchWithCondition:self.conditionTextField.text
                   isRefresh:NO
             completeHandler:^(NSError *error) {
                 [footer endRefreshing];
    }];
}

- (void)tableView:(UITableView *)tableView headerBeginRefresh:(MJRefreshStateHeader *)header{
    [self fetchWithCondition:self.conditionTextField.text
                   isRefresh:YES
             completeHandler:^(NSError *error) {
                 [header endRefreshing];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id obj = [self.viewModel searchItemAtIndexPath:indexPath];
    [self.navigationController popViewControllerAnimated:YES];
    [self.searchDelegate searchTableViewController:self didEndSearch:obj];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NMSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NMSearchTableViewCell" forIndexPath:indexPath];
    
    cell.iconView.image = [self.viewModel imageAtIndexPath:indexPath];
    
    cell.nameLabel.text = [self.viewModel nameAtIndexPath:indexPath];
    
    cell.subNameLabel.text = [self.viewModel subNameAtIndexPath:indexPath];
    
    return cell;
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
