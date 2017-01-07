//
//  NMViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "NMViewController.h"
#import "NMHUDHandler.h"

@interface NMViewController ()

@property (nonatomic, strong) PCCWException *exception;

@property (nonatomic, strong) NMHUDHandler *HUDHandler;

@end

@implementation NMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.exception = [PCCWException exceptionWithHandler:self];
    
    self.HUDHandler = [NMHUDHandler handlerWithLoadingHandler:self];
}

- (BOOL)showAlertWithError:(NSError *)error{
    return [self.exception handleExceptionWithError:error];
}

- (void)showMessage:(NSString *)message
           userInfo:(NSDictionary *)userInfo
    completeHandler:(void (^)(NSDictionary * _Nullable userInfo)) handler{
    NSError *error = errorWithCode(-1, message);
    [self.exception handleExceptionWithError:error
                             completeHandler:^(BOOL isShowError, NSError *error) {
                                 if (handler) handler(userInfo);
                             }];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
