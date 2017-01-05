//
//  PCCWWSDLParsers.m
//  PCCWFoundation
//
//  Created by 李智慧 on 14/12/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import "PCCWWSDLParsers.h"

/**
 <definitions>
 
 <types>
 definition of types........
 </types>
 
 <message>
 definition of a message....
 </message>
 
 <portType>
 definition of a port.......
 </portType>
 
 <binding>
 definition of a binding....
 </binding>
 
 </definitions>
 */

DDXMLElement *types_schema(DDXMLElement *definitions) {
    DDXMLElement *types = [definitions elementForName:@"types"];
    
    DDXMLElement *types_Schema = [types elementForName:@"schema"];
    
    return types_Schema;
}

DDXMLElement *messageOfMessages(NSArray<DDXMLElement *> *messages, NSString *methodName) {
    for (DDXMLElement *message in messages) {
        NSString *attributeName = [[message attributeForName:@"name"] stringValue];
        if ([attributeName isEqualToString:methodName]) return message;
    }
    return nil;
}

NSArray <DDXMLElement *> *types_schema_elements(DDXMLElement *definitions) {
    return [types_schema(definitions) elementsForName:@"element"];
}

DDXMLElement *message_part(DDXMLElement *message){
    return [message elementForName:@"part"];
}

NSString *messageName(NSArray<DDXMLElement *> *messaegs, NSString *methodName) {
    DDXMLElement *message = messageOfMessages(messaegs, methodName);
    
    DDXMLElement *messagePart = message_part(message);
    
    return [[[[messagePart attributeForName:@"element"] stringValue] componentsSeparatedByString:@":"] lastObject];
}

DDXMLElement *types_schema_element(DDXMLElement *definitions, NSString *methodName) {
    for (DDXMLElement *element in types_schema_elements(definitions)) {
        if([[[element attributeForName:@"name"] stringValue] isEqualToString:methodName])
            return element;
    }
    return nil;
}

DDXMLElement *types_schema_elements_complextype(DDXMLElement *defineintions, DDXMLElement *element) {
    DDXMLElement *complexType = [element elementForName:@"complexType"];
    
    if (complexType) return complexType;
    
    NSArray *complexTypes = [types_schema(defineintions) elementsForName:@"complexType"];
    
    for (DDXMLElement *complexType in complexTypes) {
        NSString *complexTypeName = [[complexType attributeForName:@"name"] stringValue];
        
        NSString *elementName = [[element attributeForName:@"name"] stringValue];
        
        if ([complexTypeName isEqualToString:elementName]) return complexType;
    }
    
    return nil;
}

DDXMLElement *types_schema_elements_complextype_sequence(DDXMLElement *definitions, NSString *methodName){
    DDXMLElement *element = types_schema_element(definitions, methodName);
    
    DDXMLElement *complextype = types_schema_elements_complextype(definitions, element);
    
    DDXMLElement *sequence = [complextype elementForName:@"sequence"];
    
    return sequence;
}

NSArray <DDXMLElement *> *types_schema_element_complextype_sequence_elements(DDXMLElement *definitions,NSString *methodName){
    return (NSArray <DDXMLElement *> *)[types_schema_elements_complextype_sequence(definitions, methodName) children];
}

NSArray <DDXMLElement *> * messages(DDXMLElement *definitions){
    return [definitions elementsForName:@"message"];
}

@interface PCCWWSDLParsers ()

@property (nonatomic, strong) DDXMLElement *definitions;

@property (nonatomic, copy) NSString *targetNamespace;

@end

@implementation PCCWWSDLParsers


+ (instancetype)WSDLParserWithPath:(NSString *)path{
    return [[self alloc] initWithPath:path];
}

- (instancetype)initWithPath:(NSString *)path
{
    if (!path) return nil;
    
    self = [super init];
    if (self) {
        NSString *xml = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];
        
        self.definitions = [[DDXMLElement alloc] initWithXMLString:xml
                                                             error:nil];
        
        self.targetNamespace = [[types_schema(self.definitions) attributeForName:@"targetNamespace"] stringValue];
    }
    return self;
}

- (NSArray *)parameterNamesFromMethodName:(NSString *)methodName{
    NSArray <DDXMLElement *> *elements = types_schema_element_complextype_sequence_elements(self.definitions, methodName);
    
    NSMutableArray *parameter = [NSMutableArray array];
    
    for (DDXMLElement *element in elements) {
        [parameter addObject:[[element attributeForName:@"name"] stringValue]];
    }
    
    return parameter;
}

- (NSString *)SOAPContentWithMethodName:(NSString *)methodName
                             parameters:(NSDictionary *)parameters{
    DDXMLElement *root = [DDXMLElement elementWithName:@"soap:Envelope"];
    
    [root addNamespace:[DDXMLNode namespaceWithName:@"soap"
                                        stringValue:@"http://schemas.xmlsoap.org/soap/envelope/"]];
    
    DDXMLElement *header = [DDXMLElement elementWithName:@"soap:Header"];
    
    DDXMLElement *body = [DDXMLElement elementWithName:@"soap:Body"];
    
    DDXMLElement *message = [DDXMLElement elementWithName:messageName(messages(self.definitions), methodName)
                                                    xmlns:self.targetNamespace];
    
    if (!message) return nil;
    
    NSArray *paramterNames = [self parameterNamesFromMethodName:methodName];
    
    for (NSString *parameterName in paramterNames) {
        NSString *value = parameters[parameterName];
        DDXMLElement *parameter = [DDXMLElement elementWithName:parameterName
                                                    stringValue:value];
        [message addChild:parameter];
    }
    
    [body addChild:message];
    [root addChild:header];
    [root addChild:body];
    
    return [root XMLString];
}


@end
