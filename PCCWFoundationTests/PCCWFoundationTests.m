//
//  PCCWFoundationTests.m
//  PCCWFoundationTests
//
//  Created by 李智慧 on 13/12/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PCCWWSDLParsers.h"

@interface PCCWFoundationTests : XCTestCase

@end

@implementation PCCWFoundationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSString *path = [[NSBundle bundleForClass:[PCCWFoundationTests class]] pathForResource:@"User" ofType:@"xml"];
    
    PCCWWSDLParsers *pars = [PCCWWSDLParsers WSDLParserWithPath:path];
    
    NSString *xml = [pars SOAPContentWithMethodName:@"getUserList"
                                         parameters:@{@"arg0" : @"xxxxxxxx"}];
    
    NSLog(@"xml %@",xml);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
