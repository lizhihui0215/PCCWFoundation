//
//  PCCWTabBarViewController.m
//  PCCWFoundation
//
//  Created by 李智慧 on 28/11/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import "PCCWTabBarViewController.h"
#import "PCCWHUDHandler.h"

@interface PCCWTabBarViewController ()

@end

@implementation PCCWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)languageDidChanged:(NSNotification *)notification {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
