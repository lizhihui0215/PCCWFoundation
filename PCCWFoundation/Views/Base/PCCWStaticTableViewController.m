//
//  PCCWStaticTableViewController.m
//  PCCWFoundation
//
//  Created by 李智慧 on 09/10/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "PCCWStaticTableViewController.h"
#import "PCCWHUDHandler.h"
#import <BlocksKit/BlocksKit.h>

@interface PCCWStaticTableViewController ()

@property (nonatomic, strong) PCCWException *exception;

@property (nonatomic, strong) PCCWHUDHandler *HUDHandler;

@end

@implementation PCCWStaticTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    addLanguageChangedNotification(self);
    NSNotification *notification = [NSNotification notificationWithName:PCCWLocalizedLanguageChangedNotification
                                                                 object:[PCCWLocalized defaultLocalized].preferredLanguage];
    [self languageDidChanged:notification];

    self.exception = [PCCWException exceptionWithHandler:self];
    
    self.HUDHandler = [PCCWHUDHandler handlerWithLoadingHandler:self];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    addLanguageChangedNotification(self);
    NSNotification *notification = [NSNotification notificationWithName:PCCWLocalizedLanguageChangedNotification
                                                                 object:[PCCWLocalized defaultLocalized].preferredLanguage];
    [self languageDidChanged:notification];
}

- (void)languageDidChanged:(NSNotification *)notification {
}

- (void)removeFooterView{
    UIView *view = [[UIView alloc] init];

    view.backgroundColor = [UIColor whiteColor];

    self.tableView.tableFooterView = view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)showAlertWithError:(NSError *)error{
    return [self.exception handleExceptionWithError:error];
}

- (void)showAlertWithError:(NSError *)error
           completeHandler:(void (^)(BOOL isShowError, NSError *error)) handler{
    [self.exception handleExceptionWithError:error completeHandler:handler];
}

- (void)showHUDWithMessage:(NSString *)message forView:(UIView *)view{
    [self.HUDHandler showHUDWithMessage:message forView:view];
}

- (void)showHUDWithMessage:(NSString *)message{
    [self.HUDHandler showHUDWithMessage:message];
}

- (void)hidHUD{
    [self.HUDHandler hidenHUD];
}

- (void)hidHUDForView:(UIView *)view{
    [self.HUDHandler hidenHUDFor:view];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
