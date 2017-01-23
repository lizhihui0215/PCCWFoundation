//
//  UIViewController+PCCWAlert.h
//  PCCWFoundation
//
//  Created by 李智慧 on 20/01/2017.
//  Copyright © 2017 PCCW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCCWLocalized.h"
#import "PCCWAppearance.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (PCCWExtension)<PCCWAppearance, PCCWLocalizedProtocol>

@property (nonatomic, assign) NSString *confirmCancelTitle PCCW_APPEARANCE_SELECTOR;

@property (nonatomic, assign) NSString *confirmOKTitle PCCW_APPEARANCE_SELECTOR;

@property (nonatomic, assign) NSString *errorOkTitle PCCW_APPEARANCE_SELECTOR;

+ (id)appearance;

- (BOOL)showAlertWithError:(nullable NSError *)error;

- (void)showAlertWithError:(nullable NSError *)error
           completeHandler:(void (^)(BOOL isShowError, NSError *error)) handler;

- (void)showHUDWithMessage:(nullable NSString *)message;

- (void)hidHUD;

- (void)hidHUDForView:(UIView *)view;

- (void)showHUDWithMessage:(NSString *)message forView:(UIView *)view;

- (void)showConfirmWithTitle:(NSString *)title
                     message:(NSString *)message
             completeHandler:(void (^) (BOOL isCancel))completeHandler;
@end

NS_ASSUME_NONNULL_END
