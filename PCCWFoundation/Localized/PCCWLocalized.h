//
//  PCCWLocalized.h
//  QDF
//
//  Created by 李智慧 on 18/01/2017.
//  Copyright © 2017 PCCW. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const PCCWLocalizedLanguageChangedNotification;

FOUNDATION_EXPORT void addLanguageChangedNotification(UIViewController *viewController);

@protocol PCCWLocalizedProtocol <NSObject>

- (void)languageDidChanged:(NSNotification *)notification;

@end

@interface PCCWLocalized : NSObject

+ (instancetype)defaultLocalized;

@property (nonatomic, strong) NSString *preferredLanguage;

@end
