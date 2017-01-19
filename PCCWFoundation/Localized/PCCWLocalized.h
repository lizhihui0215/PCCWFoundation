//
//  PCCWLocalized.h
//  QDF
//
//  Created by 李智慧 on 18/01/2017.
//  Copyright © 2017 PCCW. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const PCCWLocalizedLanguageChangedNotification;

@interface PCCWLocalized : NSObject

+ (instancetype)defaultLocalized;

@property (nonatomic, strong) NSString *preferredLanguage;

@end
