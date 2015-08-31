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
@property (strong, nonatomic) IBOutlet UIButton *muteButton;
@property (strong, nonatomic) IBOutlet UIImageView *muteImageView;
@property (nonatomic) BOOL muteSound;
@property (nonatomic) NSDate *startTime;  //
@property (nonatomic) NSInteger duration;
@property (nonatomic) NSTimer *StopwatchTimer;
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
    self.muteSound = NO;
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
    self.muteImageView.image = [UIImage imageNamed: @"SoundOn"];
    
#pragma mark - Ringtones
    
    NSString *path = [NSString stringWithFormat:@"%@/Clock-Ticking(1minute).mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    _clock = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    
    
    NSString *path2 = [NSString stringWithFormat:@"%@/TimerIsOff.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl2 = [NSURL fileURLWithPath:path2];
    _timerIsOver = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl2 error:nil];
}

#pragma mark - Buttons

- (IBAction)muteButton:(id)sender {
    if (self.muteSound == YES) {
        self.muteSound = NO;
        [_clock play];
        self.muteImageView.image = [UIImage imageNamed: @"SoundOn"];
    }
    else  {
        self.muteSound = YES;
        [_clock stop];
        self.muteImageView.image = [UIImage imageNamed: @"SoundOff"];
    }
}

- (IBAction)startStopButton:(id)sender {

    NSString *startStopActualLabel =  self.startStopButton.titleLabel.text;
    
    // START button tapped
    if ([startStopActualLabel isEqualToString:@"START"] ) {
        self.pauseResumeButton.enabled = NO;
        self.pauseResumeButton.backgroundColor = [UIColor grayColor];
        [self startTimer:self.picker.countDownDuration];
            if (self.muteSound == NO) {
                [_clock play];
            }
            else if (self.muteSound == YES) {
                [_clock stop];
            }
        }
    else      // STOP button tapped
    {
        self.pauseResumeButton.enabled = YES;
        self.pauseResumeButton.backgroundColor = [UIColor colorWithRed:0.93 green:0.91 blue:0.23 alpha:1.0];
        [_clock stop];
        [_timerIsOver stop];
        [self stopTimer];
    }
    
    
}






- (IBAction)pauseResumeButtonTapped:(id)sender {
    
    
    if (self.isPaused == NO) {
        
        [self pauseTimer];
        
        self.isPaused = YES;
        
        [_clock stop];
        
        
        
    } else{
        
        [self resumeTimer];
        
        self.isPaused = NO;
        
        if (self.muteSound == NO) {
            
            [_clock play];
            
        }
        
        else if (self.muteSound == YES) {
            
            [_clock stop];
            
        }
        
        
        
    }
    
    
    
}


#pragma mark - Timers


- (void)spinit:(NSTimer *)timer

{
    
    static float prog = 0.0;
    
    
    
    prog +=  (0.1/self.duration);
    
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
    
    NSLog(@"self.elapsedTime %lu",self.elapsedTime);
    
    NSLog(@"self.duration %lu",self.duration);
    
    
    
    
    
    self.elapsedTime = [now timeIntervalSinceDate:self.startTime];
    
    
    
    
    seconds = (self.duration - self.elapsedTime) % 60;
    
    minutes = ((self.duration - self.elapsedTime) / 60) % 60;
    
    hours = ((self.duration - self.elapsedTime) / 3600) % 24;
    
    
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02li:%02li:%02li", (long)hours, (long)minutes, (long)seconds];
    
    
    
    if (self.elapsedTime == self.duration) {
        
        [_timerIsOver play];
        
        [self alertView];
        
        [timer invalidate];
        
    }
    
}




#pragma mark - Time methods




-(void)startTimer:(NSInteger) duration {
    
    // set self.startTime to now
    
    
    self.duration = duration;
    
    self.startTime = [[NSDate alloc] init];
    
    
    
    self.StopwatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    
    self.circularTimerProgress = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(spinit:) userInfo:nil repeats:YES];
    
    
    
    
    
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
    
    [self.StopwatchTimer invalidate];
    
    [self.circularTimerProgress invalidate];
    
    self.circularTimerProgress = nil; //i need to stop thisssssssssss :@@@@@
    
    
    
    
    
    [self.startStopButton setTitle:@"START" forState:UIControlStateNormal];
    
    self.startStopButton.backgroundColor = [UIColor colorWithRed:0.31 green:0.60 blue:0.19 alpha:1.0];
    
    self.pauseResumeButton.enabled = NO;
    
    self.pauseResumeButton.backgroundColor = [UIColor grayColor];
    
    
    
    self.timeLabel.hidden = YES;
    
    self.picker.hidden = NO;
    
    self.spinnerView.hidden = YES;
    
}



-(void) pauseTimer {
    
    [self.StopwatchTimer invalidate];
    
    [self.circularTimerProgress invalidate];
    
    
    
    [self.pauseResumeButton setTitle:@"RESUME" forState:UIControlStateNormal];
    
}



- (void) resumeTimer; {
    
    
    
    [self startTimer:self.duration - self.elapsedTime];
    
    [self.pauseResumeButton setTitle:@"PAUSE" forState:UIControlStateNormal];
    
}


#pragma mark - Alert View

-(void) alertView{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"TIMER!!" message:@"Time is up!" delegate:self cancelButtonTitle:@"Stop" otherButtonTitles: nil];
    
    [alert show];
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0)
        
    {
        
        [ _timerIsOver stop];
        
        self.timeLabel.hidden = YES;
        
        self.picker.hidden = NO;
        
        self.spinnerView.hidden = YES;
        
    }
    
}



@end

