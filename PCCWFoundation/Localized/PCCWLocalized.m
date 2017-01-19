//
//  PCCWLocalized.m
//  QDF
//
//  Created by 李智慧 on 18/01/2017.
//  Copyright © 2017 PCCW. All rights reserved.
//

#import "PCCWLocalized.h"
#import <objc/runtime.h>

NSString * const PCCWLocalizedLanguageChangedNotification = @"con.pccw.localized.language.changed";

static void * PCCWLocalizedBundleKey = &PCCWLocalizedBundleKey;

inline void addLanguageChangedNotification(UIViewController *viewController){
    [[NSNotificationCenter defaultCenter] removeObserver:viewController
                                                    name:PCCWLocalizedLanguageChangedNotification
                                                  object:nil];
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
    [[NSNotificationCenter defaultCenter] addObserver:viewController
                                             selector:@selector(languageDidChanged:)
                                                 name:PCCWLocalizedLanguageChangedNotification
                                               object:nil];
    #pragma clang diagnostic pop
}


@interface PCCWLocalizedBundle : NSBundle

@end

@implementation PCCWLocalizedBundle

- (NSString *)localizedStringForKey:(NSString *)key
                              value:(NSString *)value
                              table:(NSString *)tableName
{
    NSBundle *bundle = objc_getAssociatedObject(self, &PCCWLocalizedBundleKey);
    if (bundle) {
        return [bundle localizedStringForKey:key value:value table:tableName];
    }
    else {
        return [super localizedStringForKey:key value:value table:tableName];
    }
}

@end

@interface PCCWLocalized ()

@property (nonatomic, strong) NSMutableArray *supportLanguages;

@end

@implementation PCCWLocalized

+ (instancetype)defaultLocalized{
    static PCCWLocalized *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (BOOL)isCurrentLanguageRTL
{
    return ([NSLocale characterDirectionForLanguage:self.supportLanguages.firstObject] == NSLocaleLanguageDirectionRightToLeft);
}

- (void)setPreferredLanguage:(NSString *)preferredLanguage{
    if (!preferredLanguage) return;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle], [PCCWLocalizedBundle class]);
    });
    
    [[NSUserDefaults standardUserDefaults] setObject:@[preferredLanguage] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
    if ([self isCurrentLanguageRTL]) {
        if ([[[UIView alloc] init] respondsToSelector:@selector(setSemanticContentAttribute:)]) {
            [[UIView appearance] setSemanticContentAttribute:
             UISemanticContentAttributeForceRightToLeft];
        }
    }else {
        if ([[[UIView alloc] init] respondsToSelector:@selector(setSemanticContentAttribute:)]) {
            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:[self isCurrentLanguageRTL] forKey:@"AppleTextDirection"];
    [[NSUserDefaults standardUserDefaults] setBool:[self isCurrentLanguageRTL] forKey:@"NSForceRightToLeftWritingDirection"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    id value = preferredLanguage ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:preferredLanguage ofType:@"lproj"]] : nil;
    
    objc_setAssociatedObject([NSBundle mainBundle], &PCCWLocalizedBundleKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PCCWLocalizedLanguageChangedNotification object:self.preferredLanguage];
}

- (NSString *)preferredLanguage{
    return [[NSUserDefaults standardUserDefaults] arrayForKey:@"AppleLanguages"][0];
}


@end


