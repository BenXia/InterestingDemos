//
//  FilterDemoAppDelegate.h
//  FilterDemo
//
//  Created by Kesalin on 6/27/11.
//  Copyright 2011 kesalin@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterDemoViewController;

@interface FilterDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    FilterDemoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet FilterDemoViewController *viewController;

@end

