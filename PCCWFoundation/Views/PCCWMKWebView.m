//
//  PCCWMKWebView.m
//  QDF
//
//  Created by 李智慧 on 09/01/2017.
//  Copyright © 2017 PCCW. All rights reserved.
//

#import "PCCWMKWebView.h"
#import <Masonry/Masonry.h>

@interface PCCWMKWebView ()

@end

@implementation PCCWMKWebView


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.webView];
        self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];

    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints{
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [super updateConstraints];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
