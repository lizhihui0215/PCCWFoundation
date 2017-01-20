//
//  PCCWException.m
//  PCCWFoundation
//
//  Created by 李智慧 on 7/12/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "UIAlertController+Blocks.h"
#import "UIViewController+PCCWExtension.h"

NSString * const kExceptionCode = @"com.pccw.foundation.exception.code";

NSString * const kExceptionMessage = @"NSLocalizedDescription";

static BOOL IsShowing = NO;

NSError * errorWithDomain(NSString * domain, NSInteger code, NSString *message){
    return [NSError errorWithDomain:domain
                               code:code
                           userInfo:@{kExceptionCode : @(code),
                                      kExceptionMessage : message}];
}

NSError * errorWithCode(NSInteger code, NSString *message){
    return errorWithDomain(@"", code, message);
}

@interface PCCWException ()

@property (nonatomic, weak) UIViewController *handler;
@end

@implementation PCCWException

- (instancetype)initWithHandler:(UIViewController *)handler{
    self = [super init];
    if (self) {
        self.handler = handler;
    }
    return self;
}

+ (instancetype)exceptionWithHandler:(UIViewController *)handler{
    return [[self alloc] initWithHandler:handler];
}

- (BOOL)handleExceptionWithError:(NSError *)error{
    
    return [self handleExceptionWithError:error completeHandler:nil];
}

- (BOOL)handleExceptionWithError:(NSError *)error
                 completeHandler:(void (^)(BOOL isShowError, NSError *error)) handler{

    if (IsShowing || !error) {
        if(handler) handler(NO, error);
        return NO;
    }
    
    IsShowing = YES;
    
    NSString *code = [error.userInfo[kExceptionCode] stringValue];
    
    NSString *message = error.userInfo[kExceptionMessage];
    
    
    [UIAlertController showAlertInViewController:self.handler
                                       withTitle:message
                                         message:code
                               cancelButtonTitle:self.handler.errorOkTitle
                          destructiveButtonTitle:nil
                               otherButtonTitles:nil
                                        tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                            IsShowing = NO;
                                            if(handler) handler(YES,error);
                                        }];
    return YES;
}

- (void)dealloc
{
    IsShowing = NO;
}

@end
