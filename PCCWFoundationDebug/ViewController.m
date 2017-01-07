//
//  ViewController.m
//  PCCWFoundationDebug
//
//  Created by 李智慧 on 05/01/2017.
//  Copyright © 2017 PCCW. All rights reserved.
//

#import "ViewController.h"




@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle bundleForClass:[PCCWFoundationTests class]] pathForResource:@"Weather" ofType:@"xml"];
    
    PCCWWSDLParsers *pars = [PCCWWSDLParsers WSDLParserWithPath:path];
    
    NSString *xml = [pars SOAPContentWithMethodName:@"getWeatherbyCityName"
                                         parameters:@{}];
    
    NSLog(@"xml %@",xml);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
