//
//  PCCWException.h
//  PCCWFoundation
//
//  Created by 李智慧 on 7/12/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString * const kExceptionCode;

FOUNDATION_EXPORT NSString * const kExceptionMessage;

FOUNDATION_EXPORT NSError * errorWithDomain(NSString * domain, NSInteger code, NSString *message);

FOUNDATION_EXPORT NSError * errorWithCode(NSInteger code, NSString *message);


@interface PCCWException : NSObject

+ (instancetype)exceptionWithHandler:(UIViewController *)handler;

- (BOOL)handleExceptionWithError:(NSError *)error;

- (BOOL)handleExceptionWithError:(NSError *)error
                 completeHandler:(void (^)(BOOL isShowError, NSError *error)) handler;

@end
