//
//  PCCWCheckBox.m
//  PCCWFoundation
//
//  Created by 李智慧 on 19/01/2017.
//  Copyright © 2017 PCCW. All rights reserved.
//

#import "PCCWCheckBox.h"
#import <BlocksKit/UIControl+BlocksKit.h>


@implementation PCCWCheckBox


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    [self bk_addEventHandler:^(id sender) {
        self.selected = !self.isSelected;
    } forControlEvents:UIControlEventTouchDown];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
