//
//  PCCWMKWebView.h
//  QDF
//
//  Created by 李智慧 on 09/01/2017.
//  Copyright © 2017 PCCW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <PCCWWebViewJavascriptBridge/PCCWWebViewJavascriptBridge.h>

@interface PCCWMKWebView : UIView

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) WebViewJavascriptBridge* bridge;

@end
