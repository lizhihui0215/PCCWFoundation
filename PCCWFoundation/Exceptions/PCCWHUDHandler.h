//
//  PCCWHUDHandler.h
//  PCCWFoundation
//
//  Created by 李智慧 on 8/21/15.
//  Copyright (c) 2015 lizhihui. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PCCWHUDHandler : NSObject
@property (nonatomic, weak, readonly) UIViewController *loadingHandler;

- (instancetype)initWithLoadingHandler:(UIViewController *)loadingHandler;

- (void)showHUDWithMessage:(NSString *)message forView:(UIView *)view;

- (void)showHUDWithMessage:(NSString *)message;

- (void)hidenHUD;

- (void)hidenHUDFor:(UIView *)view;

+ (instancetype)handlerWithLoadingHandler:(UIViewController *)loadingHandler;

@end
