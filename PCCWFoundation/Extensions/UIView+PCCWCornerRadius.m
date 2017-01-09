//
//  UIView+NMCornerRadius.m
//  PCCWCornerRadius
//
//  Created by 李智慧 on 01/11/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import "UIView+PCCWCornerRadius.h"

@implementation UIView (PCCWCornerRadius)

- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}

- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = [borderColor CGColor];
}

- (UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderWidth:(CGFloat )borderWidth{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}

@end
