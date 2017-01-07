//
//  NMStaticTableViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 09/10/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NMStaticTableViewController : UITableViewController
- (BOOL)showAlertWithError:(nullable NSError *)error;

- (void)showAlertWithError:(nullable NSError *)error
           completeHandler:(void (^)(BOOL isShowError, NSError *error)) handler;

- (void)showHUDWithMessage:(nullable NSString *)message;

- (void)hidHUD;

- (void)hidHUDForView:(UIView *)view;

- (void)showHUDWithMessage:(NSString *)message forView:(UIView *)view;

- (void)removeFooterView;
@end

NS_ASSUME_NONNULL_END
