//
//  CustomURLCache.h
//  TestDemo
//
//  Created by Ben on 16/9/12.
//  Copyright © 2016年 Ben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface CustomURLCache : NSURLCache

@property (nonatomic, strong) WKWebView *webView;

@end
