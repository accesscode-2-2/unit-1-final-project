//
//  TimerViewController.m
//  Time
//
//  Created by Diana Elezaj on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()
@property (nonatomic) NSDate *startTime;  //


@end

@implementation TimerViewController
- (void)timerFired:(NSTimer *)timer {
	NSLog(@"hi hi");
	NSDate *now = [[NSDate alloc] init];
	NSInteger elapsedTime = [now timeIntervalSinceDate:self.startTime];
	
	
	self.remainingTimeLabel.text = [NSString stringWithFormat:@"%lu", self.duration - elapsedTime];
}

- (IBAction)startStopButtonTapped:(id)sender {
	self.duration = 30;
	
	NSLog(@"i clicked start");
	NSString *startStopActualLabel =  self.startStopButton.titleLabel.text;
	if ([startStopActualLabel isEqualToString:@"START"] ) {
		// set self.startTime to now
		self.startTime = [[NSDate alloc] init];
		self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
		// change the button label to "Stop" so we know it's running
		[self.startStopButton setTitle:@"STOP" forState:UIControlStateNormal];
		
	} else {
		NSLog(@"else");
		[self.timer invalidate];
		
		[self.startStopButton setTitle:@"START" forState:UIControlStateNormal];
		
	}
	
	
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
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
