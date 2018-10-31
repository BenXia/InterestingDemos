//
//  ViewController.m
//  Shere1
//
//  Created by zhangmh on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"CloudBG@2x.png"];
    [self.view addSubview:imageView];
    [imageView release];
    
    CloudView *cloud = [[CloudView alloc] initWithFrame:self.view.bounds
                                           andNodeCount:50];
    
    cloud.delegate = self;
    [self.view addSubview:cloud];
    [cloud release];
}

- (void)didSelectedNodeButton:(CloudButton *)button
{
    NSLog(@"---%d",button.tag);
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
