//
//  PCCWWebServiceRequestSerializer.h
//  PCCWFoundation
//
//  Created by 李智慧 on 14/12/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "PCCWWSDLParsers.h"

@interface PCCWWebServiceRequestSerializer : AFHTTPRequestSerializer

@property (nonatomic, copy) NSString *path;

@property (nonatomic, copy) NSString *methodName;

+ (instancetype)serializerWithPath:(NSString *)path methodName:(NSString *)methodName;

@end
