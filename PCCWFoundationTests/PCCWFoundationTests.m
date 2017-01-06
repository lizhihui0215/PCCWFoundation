//
//  PCCWFoundationTests.m
//  PCCWFoundationTests
//
//  Created by 李智慧 on 13/12/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PCCWWSDLParsers.h"
#import "PCCWNetworkServices.h"
#import <AFNetworkActivityLogger/AFNetworkActivityLogger.h>

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

- (void)testNetworkServices{
    NSString *path = [[NSBundle bundleForClass:[PCCWFoundationTests class]] pathForResource:@"Weather" ofType:@"xml"];

    PCCWSOAPMethod *method = [[PCCWSOAPMethod alloc] init];
    
    method.SOAPFilePath = path;
    
    method.requestMethodName = @"getSupportCity";
    
    PCCWNetworkServicesBaseURL = @"http://www.webxml.com.cn";
    
    XCTestExpectation *ex = [self expectationWithDescription:@"document open"];
    
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    
    id<AFNetworkActivityLoggerProtocol> log = [[AFNetworkActivityLogger sharedLogger].loggers anyObject] ;
    
    [log setLevel:AFLoggerLevelDebug];
    
    [[PCCWNetworkServices defaultServices] POST:@"/WebServices/WeatherWebService.asmx"
                                     SOAPMethod:method
                                     identifier:@""
                                     parameters:@{@"byProvinceName" : @""}
                                       progress:nil
                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                            NSLog(@"responseObject %@",responseObject);
                                            [ex fulfill];
                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                            NSLog(@"error %@",error);
                                            [ex fulfill];
                                        }];
    
    [self waitForExpectationsWithTimeout:60 handler:^(NSError *error) {
        NSLog(@"test case over");
    }];

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
