//
//  TimerViewController.m
//  Time
//
//  Created by Diana Elezaj on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()
@property (nonatomic) NSInteger countDown;
@end

@implementation TimerViewController



- (void) advanceTimer:(NSTimer *)timer{
	
}


- (IBAction)startButton:(id)sender {
	
 NSTimer *countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(advanceTimer:) userInfo:nil repeats:YES];
 
 NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
 [runLoop addTimer: countDownTimer forMode:NSDefaultRunLoopMode];
 {
	 self.countDown = 60;
	 
 }
	
	
}
- (IBAction)resumeButton:(id)sender {
}

- (void)viewDidLoad {
	[super viewDidLoad];
	//	timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(currentRunLoop) userInfo:nil repeats:YES];
	//	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
	
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
