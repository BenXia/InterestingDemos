//
//  WebTestVC.m
//  TestDemo
//
//  Created by Ben on 16/9/12.
//  Copyright © 2016年 Ben. All rights reserved.
//

#import "WebTestVC.h"
#import <WebKit/WebKit.h>

@interface WebTestVC () <WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WebTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    WKUserContentController *contentController = [[WKUserContentController alloc] init];
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:@"redHeader()"
                                                      injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
                                                   forMainFrameOnly:YES];
    
    [contentController addUserScript:userScript];
    [contentController addScriptMessageHandler:self name:@"callbackHandler"];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = contentController;

    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    [self.view addSubview:self.webView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.webView.frame = self.view.bounds;
    
    NSURL *url = [NSURL URLWithString:@"http://pages.idc.changingedu.com/nativetest/test.html"];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:req];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"callbackHandler"]) {
        NSLog (@"JavaScript is sending a message %@", message.body);
        
//        __block BOOL finished = NO;
//        
//        [self.webView evaluateJavaScript:@"ocval=1;" completionHandler:^(id result, NSError *error) {
//            finished = YES;
//        }];
//        
//        while (!finished) {
//            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//        }
        
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@""
                                                       message:[NSString stringWithFormat:@"JavaScript is sending a message %@", message.body]
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"OK", nil];
        [view show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


