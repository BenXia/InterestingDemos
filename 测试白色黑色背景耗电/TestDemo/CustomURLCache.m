//
//  CustomURLCache.m
//  TestDemo
//
//  Created by Ben on 16/9/12.
//  Copyright © 2016年 Ben. All rights reserved.
//

#import "CustomURLCache.h"

@implementation CustomURLCache

- (NSCachedURLResponse*)cachedResponseForRequest:(NSURLRequest *)request {
    if ([request.HTTPMethod compare:@"GET" options:NSCaseInsensitiveSearch] != NSOrderedSame) {
        return [super cachedResponseForRequest:request];
    }
    
    NSURL* url = request.URL;
    NSString* scheme = url.scheme;
    NSString* path = url.path;
    NSString* query = url.query;
    
    if (path == nil || query == nil) {
        return [super cachedResponseForRequest:request];
    }
    
    NSData *data = [@"result=1;" dataUsingEncoding:NSUTF8StringEncoding];
    
    // Create the cacheable response
    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:[request URL]
                                                        MIMEType:@"text"
                                           expectedContentLength:[data length]
                                                textEncodingName:nil];
    NSCachedURLResponse *cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
    
    if ([path containsString:@"run"]) {
        __block BOOL finished = NO;

        [self.webView evaluateJavaScript:@"ocval=1;" completionHandler:^(id result, NSError *error) {
            finished = YES;
        }];

        while (!finished) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        
        return cachedResponse;
    }
    
    return [super cachedResponseForRequest:request];
}

@end
