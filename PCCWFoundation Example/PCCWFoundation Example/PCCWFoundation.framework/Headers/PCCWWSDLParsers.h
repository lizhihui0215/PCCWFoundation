//
//  PCCWWSDLParsers.h
//  PCCWFoundation
//
//  Created by 李智慧 on 14/12/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <KissXML/KissXML.h>

@interface PCCWWSDLParsers : NSObject

+ (instancetype)WSDLParserWithPath:(NSString *)path;

- (NSString *)SOAPContentWithMethodName:(NSString *)methodName
                             parameters:(NSDictionary *)parameters;

+ (NSString *)SOAPResultWithMethodName:(NSString *)methodName
                                  data:(NSString *)data;

@end
