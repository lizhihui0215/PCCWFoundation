//
//  UIViewController+PCCWAlert.m
//  PCCWFoundation
//
//  Created by 李智慧 on 20/01/2017.
//  Copyright © 2017 PCCW. All rights reserved.
//

#import "UIViewController+PCCWExtension.h"
#import "UIAlertController+Blocks.h"
#import <BlocksKit/BlocksKit.h>
#import "PCCWHUDHandler.h"

static inline void pccw_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}


static inline BOOL pccw_addMethod(Class theClass, SEL selector, Method method) {
    return class_addMethod(theClass, selector,  method_getImplementation(method),  method_getTypeEncoding(method));
}

@interface UIViewController ()

@property (nonatomic, strong) PCCWException *exception;

@property (nonatomic, strong) PCCWHUDHandler *HUDHandler;

@end

@implementation UIViewController (PCCWExtension)


+ (void)load{
    pccw_swizzleSelector([self class], @selector(viewDidLoad), @selector(pccw_viewDidLoad));
    
    pccw_swizzleSelector([self class], @selector(awakeFromNib), @selector(pccw_awakeFromNib));
}

- (void)pccw_awakeFromNib{
    [self pccw_awakeFromNib];
    addLanguageChangedNotification(self);
    NSNotification *notification = [NSNotification notificationWithName:PCCWLocalizedLanguageChangedNotification
                                                                 object:[PCCWLocalized defaultLocalized].preferredLanguage];
    [self languageDidChanged:notification];
}

- (void)setException:(PCCWException *)exception{
    [self bk_associateValue:exception withKey:@selector(exception)];
}

- (PCCWException *)exception{
    return [self bk_associatedValueForKey:_cmd];
}

- (void)setHUDHandler:(PCCWHUDHandler *)HUDHandler{
    [self bk_associateValue:HUDHandler withKey:@selector(exception)];
}

- (PCCWHUDHandler *)HUDHandler{
    return [self bk_associatedValueForKey:_cmd];
}

- (void)pccw_viewDidLoad{
    addLanguageChangedNotification(self);
    NSNotification *notification = [NSNotification notificationWithName:PCCWLocalizedLanguageChangedNotification
                                                                 object:[PCCWLocalized defaultLocalized].preferredLanguage];
    [self languageDidChanged:notification];
    
    self.exception = [PCCWException exceptionWithHandler:self];
    
    self.HUDHandler = [PCCWHUDHandler handlerWithLoadingHandler:self];
    [self pccw_viewDidLoad];
}

- (void)languageDidChanged:(NSNotification *)notification {
}

- (BOOL)showAlertWithError:(NSError *)error{
    return [self.exception handleExceptionWithError:error];
}

- (void)showMessage:(NSString *)message
           userInfo:(NSDictionary *)userInfo
    completeHandler:(void (^)(NSDictionary * _Nullable userInfo)) handler{
    NSError *error = errorWithCode(-1, message);
    [self.exception handleExceptionWithError:error
                             completeHandler:^(BOOL isShowError, NSError *error) {
                                 if (handler) handler(userInfo);
                             }];
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

+ (void)swizzleViewDidLoadMethodForClass:(Class)theClass {
    Method pccwViewDidLoadMethod = class_getInstanceMethod(self, @selector(pccw_viewDidLoad));
    
    if (pccw_addMethod(theClass, @selector(pccw_viewDidLoad), pccwViewDidLoadMethod)) {
        pccw_swizzleSelector(theClass, @selector(viewDidLoad), @selector(pccw_viewDidLoad));
    }
}


- (void)showConfirmWithTitle:(NSString *)title
                     message:(NSString *)message
             completeHandler:(void (^) (BOOL isCancel))completeHandler{
    [UIAlertController showAlertInViewController:self
                                       withTitle:title
                                         message:message
                               cancelButtonTitle:@"取消"
                          destructiveButtonTitle:nil
                               otherButtonTitles:@[@""]
                                        tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                            completeHandler(buttonIndex == 0);
                                        }];
}


@end
