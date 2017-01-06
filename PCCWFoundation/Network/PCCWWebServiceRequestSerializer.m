//
//  PCCWWebServiceRequestSerializer.m
//  PCCWFoundation
//
//  Created by 李智慧 on 14/12/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import "PCCWWebServiceRequestSerializer.h"
#import "PCCWWSDLParsers.h"

@implementation PCCWWebServiceRequestSerializer

+ (instancetype)serializerWithPath:(NSString *)path methodName:(NSString *)methodName{
    return [[self alloc] initWithPath:path methodName:methodName];
}

- (instancetype)initWithPath:(NSString *)path methodName:(NSString *)methodName
{
    self = [super init];
    if (self) {
        self.path = path;
        self.methodName = methodName;
    }
    return self;
}

#pragma mark - AFURLRequestSerialization

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing  _Nullable *)error{
    NSParameterAssert(request);
    NSParameterAssert(self.methodName);
    NSParameterAssert(self.path);
    
    if ([self.HTTPMethodsEncodingParametersInURI containsObject:[[request HTTPMethod] uppercaseString]]) {
        return [super requestBySerializingRequest:request withParameters:parameters error:error];
    }
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    
    [self.HTTPRequestHeaders enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        if (![request valueForHTTPHeaderField:field]) {
            [mutableRequest setValue:value forHTTPHeaderField:field];
        }
    }];
    
    if (parameters) {
        PCCWWSDLParsers *parsers = [PCCWWSDLParsers WSDLParserWithPath:self.path];
        
        NSString *SOAPContent = [parsers SOAPContentWithMethodName:self.methodName
                                                        parameters:parameters];
        
        if (![mutableRequest valueForHTTPHeaderField:@"Content-Type"]) {
            [mutableRequest setValue:@"text/xml;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        }
        NSData *data = [SOAPContent dataUsingEncoding:NSUTF8StringEncoding];
        [mutableRequest setHTTPBody:data];
    }
    
    return mutableRequest;
}

@end
