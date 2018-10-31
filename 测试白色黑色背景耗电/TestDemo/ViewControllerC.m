//
//  ViewControllerC.m
//  TestDemo
//
//  Created by Ben on 2017/1/17.
//  Copyright © 2017年 Ben. All rights reserved.
//

#import "ViewControllerC.h"

static NSString *const kLastHoldMinutesKey = @"kLastHoldMinutesKey";

@interface ViewControllerC ()

@property (nonatomic, assign) BOOL isBlackBackground;
@property (nonatomic, strong) NSTimer *repeatTimer;

@end

@implementation ViewControllerC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:[NSString stringWithFormat:@"上次坚持了%d分钟", [[ud objectForKey:kLastHoldMinutesKey] intValue]]
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"我造了", nil];
    [alert show];
    
    [self startRepeatTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)startRepeatTimer {
    [self stopRepeatTimer];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:0] forKey:kLastHoldMinutesKey];
    self.repeatTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void)stopRepeatTimer {
    if (self.repeatTimer) {
        [self.repeatTimer invalidate];
        self.repeatTimer = nil;
    }
}

- (void)timerAction {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int lastHoldMinutesKey = [[ud objectForKey:kLastHoldMinutesKey] intValue];
    lastHoldMinutesKey += 1;
    [ud setObject:[NSNumber numberWithInt:lastHoldMinutesKey] forKey:kLastHoldMinutesKey];
    [ud synchronize];
}

#pragma mark - IBActions

- (IBAction)didClickBottomButtonAction:(id)sender {
    self.isBlackBackground = !self.isBlackBackground;
    
    self.view.backgroundColor = self.isBlackBackground ? [UIColor blackColor] : [UIColor whiteColor];
}

@end


