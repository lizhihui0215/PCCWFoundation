//
//  PCCWTableViewCell.m
//  PCCWFoundation
//
//  Created by 李智慧 on 7/12/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "PCCWTableViewCell.h"

@implementation PCCWTableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    // Remove seperator inset
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    // Prevent the cell from inheriting the Table View's margin settings
    if ([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [self setPreservesSuperviewLayoutMargins:NO];
    }
    // Explictly set your cell's layout margins
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
