//
//  URLCacheVC.m
//  TestDemo
//
//  Created by Ben on 16/9/12.
//  Copyright © 2016年 Ben. All rights reserved.
//

#import "URLCacheVC.h"
#import "CustomURLCache.h"
#import <WebKit/WebKit.h>

@interface URLCacheVC ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation URLCacheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
    ((CustomURLCache *)[NSURLCache sharedURLCache]).webView = self.webView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.webView.frame = self.view.bounds;
    
    NSURL *url = [NSURL URLWithString:@"http://pages.idc.changingedu.com/nativetest/test.html"];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:req];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


