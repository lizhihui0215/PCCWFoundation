//
//  ViewController.m
//  PCCWFoundation Example
//
//  Created by 李智慧 on 2017/1/7.
//  Copyright © 2017年 李智慧. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showAlertWithError:errorWithCode(0, @"xx")];

    [self showConfirmWithTitle:@"test"
                       message:@"xx"
               completeHandler:^(BOOL isCancel) {
                   NSLog(@"is cancel %d",isCancel);
               }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
