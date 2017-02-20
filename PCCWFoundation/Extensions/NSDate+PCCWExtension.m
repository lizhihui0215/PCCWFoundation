//
//  NSDate+PCCWExtension.m
//  PCCWFoundation
//
//  Created by 李智慧 on 20/02/2017.
//  Copyright © 2017 PCCW. All rights reserved.
//

#import "NSDate+PCCWExtension.h"

@implementation NSDate (PCCWExtension)

- (NSString *)stringDateWithFormat:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];;
}

@end
