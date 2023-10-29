//
//  main.m
//  FilterDemo
//
//  Created by Kesalin on 6/27/11.
//  Copyright 2011 kesalin@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterDemoAppDelegate.h"

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([FilterDemoAppDelegate class]));
    [pool release];
    return retVal;
}
