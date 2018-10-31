//
//  FilterDemoViewController.m
//  FilterDemo
//
//  Created by Kesalin on 6/27/11.
//  Copyright 2011 kesalin@gmail.com. All rights reserved.
//

#import "FilterDemoViewController.h"
#import "CVFilterPopoverController.h"
#import "FilterDemoAppDelegate.h"

@implementation FilterDemoViewController

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)dealloc
{
    [filterPopoverController release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(filterChanged:)
                                                 name:kEventFilterChanged
                                               object:nil];
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kEventFilterChanged object:nil];
}

- (IBAction)popoverButtonPressed:(id)sender
{
    if (!filterPopoverController)
    {
        CVFilterPopoverController *contentController = [[CVFilterPopoverController alloc] init];

        filterPopoverController = [[UIPopoverController alloc] initWithContentViewController:contentController];
        filterPopoverController.delegate = contentController;
        CGRect rect = contentController.view.frame;
        [filterPopoverController setPopoverContentSize:rect.size animated:NO];

        contentController.container = filterPopoverController;
        [contentController release];
    }
    
    CVFilterPopoverController *controller = (CVFilterPopoverController *)(filterPopoverController.contentViewController);
    [controller reset];
    [filterPopoverController presentPopoverFromRect:popoverButton.bounds
                                             inView:popoverButton
                           permittedArrowDirections:UIPopoverArrowDirectionUp
                                           animated:YES];
}


- (void)filterChanged:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSSet *selectedCountries = [userInfo objectForKey:@"selectedItems"];

    NSLog(@"=========================");
    NSLog(@" Filter mode - code:");

    for (NSString *str in selectedCountries)
    {
        NSArray *pairs = [str componentsSeparatedByString:@"|"];
        NSLog(@" > %@ - %@", [pairs objectAtIndex:0], [pairs objectAtIndex:1]);
    }
}

@end
