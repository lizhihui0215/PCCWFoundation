//
//  PCCWAppearance.h
//  PCCWFoundation
//
//  Created by 李智慧 on 13/12/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//


#import <Foundation/Foundation.h>


#define PCCW_APPEARANCE_SELECTOR UI_APPEARANCE_SELECTOR

@protocol PCCWAppearance <NSObject>

/** 
 To customize the appearance of all instances of a class, send the relevant appearance modification messages to the appearance proxy for the class.
 */
+ (instancetype)appearance;
@end

@interface PCCWAppearance : NSObject

/** 
 Applies the appearance of all instances to the object. 
 */
- (void)applyInvocationTo:(id)target;

/**
 Applies the appearance of all instances to the object starting from the superclass 
 */
- (void)applyInvocationRecursivelyTo:(id)target upToSuperClass:(Class)superClass;

/** 
 Returns appearance for class 
 */
+ (id)appearanceForClass:(Class)aClass;

@end
