//
//  ViewControllerA.m
//  TestDemo
//
//  Created by Ben on 2/7/15.
//  Copyright (c) 2015 Ben. All rights reserved.
//

#import "ViewControllerA.h"
#import "CustomiseViewB.h"

@interface ViewControllerA ()

@property (nonatomic, strong) CustomiseViewB *viewB;

@end

@implementation ViewControllerA

- (void)viewDidLoad
{
    [super viewDidLoad];

    _viewB = [[CustomiseViewB alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    if (_viewB.repeatTimer) {
        [_viewB.repeatTimer invalidate];
        _viewB.repeatTimer = nil;
    }
}

@end
