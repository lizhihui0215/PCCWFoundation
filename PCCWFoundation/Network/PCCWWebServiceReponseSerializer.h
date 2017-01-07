//
//  PCCWWebServiceReponseSerializer.h
//  PCCWFoundation
//
//  Created by 李智慧 on 14/12/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

@import AFNetworking;
#import "PCCWWSDLParsers.h"

@interface PCCWWebServiceReponseSerializer : AFHTTPResponseSerializer

@property (nonatomic, copy) NSString *methodName;

+ (instancetype)serializerWithMethodName:(NSString *)methodName;

@end
