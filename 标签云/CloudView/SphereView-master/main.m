//
//  main.m
//  SphereViewSample
//
//  Created by Zhao Yiqi on 13-12-8.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SphereViewAppDelegate.h"

int main(int argc, char *argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([SphereViewSampleAppDelegate class]));
    [pool release];
    return retVal;
}
