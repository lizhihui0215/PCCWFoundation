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
@property (nonatomic, strong) PCCWException *exception;

@property (nonatomic, strong) PCCWHUDHandler *HUDHandler;

@end

@implementation PCCWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.exception = [PCCWException exceptionWithHandler:self];
    
    self.HUDHandler = [PCCWHUDHandler handlerWithLoadingHandler:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)showAlertWithError:(NSError *)error{
    return [self.exception handleExceptionWithError:error];
}

- (void)showAlertWithError:(NSError *)error
           completeHandler:(void (^)(BOOL isShowError, NSError *error)) handler{
    [self.exception handleExceptionWithError:error completeHandler:handler];
}

- (void)showHUDWithMessage:(NSString *)message forView:(UIView *)view{
    [self.HUDHandler showHUDWithMessage:message forView:view];
}

- (void)showHUDWithMessage:(NSString *)message{
    [self.HUDHandler showHUDWithMessage:message];
}

- (void)hidHUD{
    [self.HUDHandler hidenHUD];
}

- (void)hidHUDForView:(UIView *)view{
    [self.HUDHandler hidenHUDFor:view];
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
