//
//  FilterDemoViewController.h
//  FilterDemo
//
//  Created by Kesalin on 6/27/11.
//  Copyright 2011 kesalin@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterDemoViewController : UIViewController
{
    IBOutlet UIButton *popoverButton;
    
    UIPopoverController *filterPopoverController;
}

- (IBAction)popoverButtonPressed:(id)sender;
- (void)filterChanged:(NSNotification *)notification;

@end

