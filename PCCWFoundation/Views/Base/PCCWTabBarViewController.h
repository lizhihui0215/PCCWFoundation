//
//  PCCWTabBarViewController.h
//  PCCWFoundation
//
//  Created by 李智慧 on 28/11/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCCWLocalizedProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface PCCWTabBarViewController : UITabBarController<PCCWLocalizedProtocol>

- (BOOL)showAlertWithError:(nullable NSError *)error;

- (void)showAlertWithError:(nullable NSError *)error
           completeHandler:(void (^)(BOOL isShowError, NSError *error)) handler;

- (void)showHUDWithMessage:(nullable NSString *)message;

- (void)hidHUD;

- (void)hidHUDForView:(UIView *)view;

- (void)showHUDWithMessage:(NSString *)message forView:(UIView *)view;


@end

NS_ASSUME_NONNULL_END
