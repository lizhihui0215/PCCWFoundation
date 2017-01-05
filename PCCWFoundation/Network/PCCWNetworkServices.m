
//
//  PCCWNetworkServices.m
//  PCCWFoundation
//
//  Created by 李智慧 on 14/12/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import "PCCWNetworkServices.h"

static __strong NSMutableDictionary<NSString *, NSNumber *> *_taskIdentifiers;

@interface PCCWNetworkServices ()

@property (class,nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *dataTaskIdentifiers;

@end

@implementation PCCWNetworkServices

+ (void)initialize{
    [super initialize];
    _taskIdentifiers = [NSMutableDictionary dictionary];
}

+ (void)setDataTaskIdentifiers:(NSMutableDictionary<NSString *,NSNumber *> *)dataTaskIdentifiers{
    _taskIdentifiers = dataTaskIdentifiers;
}

+ (NSMutableDictionary<NSString *,NSNumber *> *)dataTaskIdentifiers{
    return _taskIdentifiers;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
    }
    return self;
}

@end
