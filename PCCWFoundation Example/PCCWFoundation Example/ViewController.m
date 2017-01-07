//
//  ViewController.m
//  PCCWFoundation Example
//
//  Created by 李智慧 on 2017/1/7.
//  Copyright © 2017年 李智慧. All rights reserved.
//

#import "ViewController.h"
#import <PCCWFoundation/PCCWWSDLParsers.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Weather" ofType:@"xml"];
    
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
