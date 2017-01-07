//
//  NMViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NMViewController : UIViewController

- (BOOL)showAlertWithError:(nullable NSError *)error;

- (void)showAlertWithError:(nullable NSError *)error
           completeHandler:(void (^)(BOOL isShowError, NSError *error)) handler;

- (void)showHUDWithMessage:(nullable NSString *)message;

- (void)showMessage:(NSString *)message
           userInfo:(nullable NSDictionary *)userInfo
    completeHandler:(nullable void (^)(NSDictionary *userInfo)) handler;

- (void)hidHUD;

- (void)hidHUDForView:(UIView *)view;

- (void)showHUDWithMessage:(NSString *)message forView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
