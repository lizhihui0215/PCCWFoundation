//
//  PCCWViewController.m
//  PCCWFoundation
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "PCCWViewController.h"
#import "PCCWHUDHandler.h"

@interface PCCWViewController ()

@property (nonatomic, strong) PCCWException *exception;

@property (nonatomic, strong) PCCWHUDHandler *HUDHandler;

@end

@implementation PCCWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)languageDidChanged:(NSNotification *)notification {
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
