//
//  TimerViewController.m
//  Time
//
//  Created by Diana Elezaj on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerViewController.h"
#import "TimerDetailTableViewController.h"
#import "STKSpinnerView.h"
#import <AVFoundation/AVFoundation.h> // this allows us to include sounds!

@interface TimerViewController ()
{
    AVAudioPlayer *_clock;
    AVAudioPlayer *_timerIsOver;

 }
@property (weak, nonatomic) IBOutlet STKSpinnerView *spinnerView;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIButton *startStopButton;
@property (strong, nonatomic) IBOutlet UIButton *pauseResumeButton;
@property (strong, nonatomic) IBOutlet UIDatePicker *picker;
@property (nonatomic) NSDate *startTime;  //
@property (nonatomic) NSInteger duration;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSTimer *circularTimerProgress;

@property (nonatomic) BOOL isPaused;

@property (nonatomic) NSInteger elapsedTime;


@end

@implementation TimerViewController



- (void)viewDidLoad {
	[super viewDidLoad];
	self.picker.hidden = NO;
	self.timeLabel.hidden = YES;
	self.picker.countDownDuration = 60;
	
	self.isPaused = NO;
	
	/******  Interface layout *****/
	[self.startStopButton.titleLabel  isEqual: @"START"];
	self.startStopButton.layer.cornerRadius = 60;
	self.startStopButton.clipsToBounds = YES;
	self.startStopButton.backgroundColor = [UIColor colorWithRed:0.31 green:0.60 blue:0.19 alpha:1.0];
	
	[self.pauseResumeButton.titleLabel  isEqual: @"PAUSE"];
	self.pauseResumeButton.layer.cornerRadius = 60;
	self.pauseResumeButton.clipsToBounds = YES;
	self.pauseResumeButton.backgroundColor = [UIColor grayColor];
    self.pauseResumeButton.enabled = NO;
    
    self.spinnerView.hidden = YES;
    
    
    
#pragma mark - Ringtones
    
    // this adds ringtone sound
    NSString *path = [NSString stringWithFormat:@"%@/clock-ticking-5.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    // Create audio player object and initialize with URL to sound
    _clock = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
   
     NSString *path2 = [NSString stringWithFormat:@"%@/TimerIsOff.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl2 = [NSURL fileURLWithPath:path2];
     _timerIsOver = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl2 error:nil];
}






- (void)spinit:(NSTimer *)timer
{
    static float prog = 0.0;
    //tjetra 0.1
    //prog += 0.001;  100 sec     100,000 .. 0.00001
     //prog += 0.01;  10 sec        1000  .. 0.001
     //prog += 0.1;  1 sec          10    .. 0.01
    
    
    //tjetra 0.01
    //prog += 0.0001; 100sec        1.000.000 .. 0.000001
    //prog += 0.001;  10 sec            10000 ..
    //prog += 0.01;    1 sec
    //
    
    
    
    
    
    prog += 0.0001;
    if(prog >= 1.0) {
        prog = 1.0;
        [timer invalidate];
    }
    [[self spinnerView] setProgress:prog animated:YES];
}


- (void)timerFired:(NSTimer *)timer {
    NSInteger hours, minutes, seconds ;

	NSLog(@"hi hi");
	NSDate *now = [[NSDate alloc] init];
    
    if (self.duration != self.elapsedTime) {

	self.elapsedTime = [now timeIntervalSinceDate:self.startTime];
	
    NSLog(@"self.elapsedTime %lu",self.elapsedTime);
    NSLog(@"self.duration %lu",self.duration);
     
    seconds = (self.duration - self.elapsedTime) % 60;
    minutes = ((self.duration - self.elapsedTime) / 60) % 60;
    hours = ((self.duration - self.elapsedTime) / 3600) % 24;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02li:%02li:%02li", (long)hours, (long)minutes, (long)seconds];
    }
    else {
 //        self.timeLabel.hidden = YES;
//        self.picker.hidden = NO;
//        self.spinnerView.hidden = YES;
        [_timerIsOver play];
        [timer invalidate];
    }
 }

- (IBAction)startStopButton:(id)sender {
    
    // START button tapped
    
    NSString *startStopActualLabel =  self.startStopButton.titleLabel.text;
	if ([startStopActualLabel isEqualToString:@"START"] ) {
        self.pauseResumeButton.enabled = NO;
        self.pauseResumeButton.backgroundColor = [UIColor grayColor];

        
		[self startTimer:self.picker.countDownDuration];
       // while (true) {
            [_clock play];
      //  }
    } else      // STOP button tapped

    {
        self.pauseResumeButton.enabled = YES;
        self.pauseResumeButton.backgroundColor = [UIColor colorWithRed:0.93 green:0.91 blue:0.23 alpha:1.0];

		NSLog(@"else");
        [_clock stop];
        [_timerIsOver stop];
		[self stopTimer];
	}
	
}

-(void)startTimer:(NSInteger) duration {
	// set self.startTime to now
	
	self.duration = duration;
	self.startTime = [[NSDate alloc] init];
    
	
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
	
    self.circularTimerProgress = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(spinit:) userInfo:nil repeats:YES];
    
    
    
    
// change the button label to "Stop" so we know it's running
    
	[self.startStopButton setTitle:@"STOP" forState:UIControlStateNormal];
    self.pauseResumeButton.enabled = YES;
    self.pauseResumeButton.backgroundColor = [UIColor colorWithRed:0.93 green:0.91 blue:0.23 alpha:1.0];

	self.startStopButton.backgroundColor = [UIColor redColor];
	self.timeLabel.hidden = NO;
	self.picker.hidden = YES;
    self.spinnerView.hidden = NO;

      }

-(void) stopTimer {
	[self.timer invalidate];
    [self.circularTimerProgress invalidate];
    
    
	[self.startStopButton setTitle:@"START" forState:UIControlStateNormal];
	self.startStopButton.backgroundColor = [UIColor colorWithRed:0.31 green:0.60 blue:0.19 alpha:1.0];
    self.pauseResumeButton.enabled = NO;
    self.pauseResumeButton.backgroundColor = [UIColor grayColor];

    
	self.timeLabel.hidden = YES;
	self.picker.hidden = NO;
    self.spinnerView.hidden = YES;
    
    

}

-(void) pauseTimer {
	[self.timer invalidate];
    [self.circularTimerProgress invalidate];
    
    
	[self.pauseResumeButton setTitle:@"RESUME" forState:UIControlStateNormal];
}
	


//-(void) resumeTimer {
//	[self.pauseResumeButton setTitle:@"RESUME" forState:UIControlStateNormal];
//	self.timeLabel.hidden = NO;
//	self.picker.hidden = YES;
//	self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:[self pauseTimer] userInfo:nil repeats:NO];
//	}

	

- (void) resumeTimer; {
    
	[self startTimer:self.duration - self.elapsedTime];
	[self.pauseResumeButton setTitle:@"PAUSE" forState:UIControlStateNormal];
}



- (IBAction)pauseResumeButtonTapped:(id)sender {
	
	
	if (self.isPaused == NO) {
		[self pauseTimer];
		self.isPaused = YES;
        [_clock stop];

		
	} else{
		[self resumeTimer];
		self.isPaused = NO;
      //  while (true) {
            [_clock play];
      //  }
	}
	 
}

@end
