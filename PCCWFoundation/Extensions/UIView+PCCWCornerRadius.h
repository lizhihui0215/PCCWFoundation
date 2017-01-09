//
//  UIView+PCCWCornerRadius.h
//  PCCWCornerRadius
//
//  Created by 李智慧 on 01/11/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (PCCWCornerRadius)

@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;

@property(nonatomic, strong) IBInspectable UIColor *borderColor;

@property(nonatomic, assign) IBInspectable CGFloat borderWidth;


@end
