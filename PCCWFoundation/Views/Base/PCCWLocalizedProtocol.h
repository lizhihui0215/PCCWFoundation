//
// Created by 李智慧 on 19/01/2017.
// Copyright (c) 2017 PCCW. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PCCWLocalizedProtocol <NSObject>

@optional

- (void)languageDidChanged:(NSNotification *)notification;

@end