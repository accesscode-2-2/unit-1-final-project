//
//  PresetTimerDetailViewController.m
//  Time
//
//  Created by Xiulan Shi on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//
#import "PresetTimerDetailViewController.h"

@interface PresetTimerDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UIButton *add;
@property (weak, nonatomic) IBOutlet UIButton *subtract;

@property (weak, nonatomic) IBOutlet UILabel *weightText;

//@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UIButton *startCancelButton;

@property (weak, nonatomic) IBOutlet UIButton *pauseResumeButton;


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic) BOOL isTimerRunning;
@property (nonatomic) BOOL isPaused;

@property (nonatomic) int hours;
@property (nonatomic) int minutes;
@property (nonatomic) int seconds;

@property (nonatomic) int secondsCount;

@property (nonatomic) int weight;
@property (nonatomic) int newTime;

@property (nonatomic) NSTimer *timer;

@property AVAudioPlayer *timeEnds;

@end

@implementation PresetTimerDetailViewController


- (AVAudioPlayer *)setupAudioPlayerWithFile:(NSString *)file type:(NSString *)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:type];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error;
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (!audioPlayer) {
        NSLog(@"%@", [error description]);
    }
    return audioPlayer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nameLabel.text = self.currentTimer.timerName;
    self.imageView.image = [UIImage imageNamed:self.currentTimer.imageName];
    
    if ([self.nameLabel.text isEqualToString:@"Roast Turkey"]) {
        self.weightLabel.hidden = NO;
        self.add.hidden = NO;
        self.subtract.hidden = NO;
        self.weightText.hidden = NO;
        self.weight = self.currentTimer.countDownDuration/60/13;
        self.newTime = self.currentTimer.countDownDuration;
    }
    else {
        self.weightLabel.hidden = YES;
        self.add.hidden = YES;
        self.subtract.hidden = YES;
        self.weightText.hidden = YES;
    }
    
    self.hours = self.currentTimer.countDownDuration/3600;
    self.minutes = (self.currentTimer.countDownDuration % 3600)/60;
    self.seconds = self.currentTimer.countDownDuration - (self.hours * 3600) - (self.minutes * 60);
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02i:%02i:%02i", self.hours, self.minutes, self.seconds];
    
    self.isTimerRunning = NO;
    self.isPaused = NO;
    self.pauseResumeButton.enabled = NO;
    self.timeEnds = [self setupAudioPlayerWithFile:@"ping-sound" type:@"mp3"];
    
    
}

- (IBAction)addButtonTapped:(id)sender {
    self.weight ++;
    self.weightLabel.text = [NSString stringWithFormat:@"%i", self.weight];
    self.newTime = self.weight * 13 * 60;
    
    self.hours = self.newTime/3600;
    self.minutes = (self.newTime % 3600)/60;
    self.seconds = self.newTime - (self.hours * 3600) - (self.minutes * 60);
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02i:%02i:%02i", self.hours, self.minutes, self.seconds];
    
}
- (IBAction)subtractButtonTapped:(id)sender {
    if (self.weight < 1) {
        return;
    }
    self.weight --;
    self.weightLabel.text = [NSString stringWithFormat:@"%i", self.weight];
    self.newTime = self.weight * 13 * 60;
    
    self.hours = self.newTime/3600;
    self.minutes = (self.newTime % 3600)/60;
    self.seconds = self.newTime - (self.hours * 3600) - (self.minutes * 60);
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02i:%02i:%02i", self.hours, self.minutes, self.seconds];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startCancelButton:(id)sender {
    
    if ([self.nameLabel.text isEqualToString:@"Roast Turkey"]) {
        self.secondsCount = self.newTime;
    }
    else
    {
        self.secondsCount = self.currentTimer.countDownDuration;
    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02i:%02i:%02i", self.hours, self.minutes, self.seconds];
    
    if (self.isTimerRunning == YES) {
        
        self.timeLabel.alpha = 0;
        [self.startCancelButton setTitle:@"START" forState:UIControlStateNormal];
        [self.pauseResumeButton setTitle:@"PAUSE" forState:UIControlStateNormal];
        self.pauseResumeButton.enabled = NO;
        
        [self.timer invalidate];
        self.timer = nil;
        
    } else {
        
        self.timeLabel.alpha = 1;
        
        [self.startCancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
        self.pauseResumeButton.enabled = YES;
        
        if (self.timer == nil) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(updateTimer)
                                                        userInfo:nil
                                                         repeats:YES];
        }
        
    }
    
    self.isTimerRunning = !self.isTimerRunning;
    
}

- (void) updateTimer {
    
    self.secondsCount--;
    
    self.hours = self.secondsCount/3600;
    self.minutes = (self.secondsCount % 3600)/60;
    self.seconds = self.secondsCount - (self.hours * 3600) - (self.minutes * 60);
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02i:%02i:%02i", self.hours, self.minutes, self.seconds];
    
    
    if (self.secondsCount <= 0) {
        
        [self.timer invalidate];
        self.timer = nil;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time Done" message:[NSString stringWithFormat:@"%@ Is Ready",self.currentTimer.timerName] delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil];
        
        [alert show];
        [self.timeEnds play];
        
        self.timeLabel.alpha = 0;
        [self.startCancelButton setTitle:@"START" forState:UIControlStateNormal];
        self.pauseResumeButton.enabled = NO;
        
    }
    
}

- (IBAction)pauseResumeButton:(id)sender {
    if (self.isPaused == NO) {
        [self.timer invalidate];
        self.timer = nil;
        
        [self.pauseResumeButton setTitle:@"RESUME" forState:UIControlStateNormal];
        
    } else {
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(updateTimer)
                                                    userInfo:nil
                                                     repeats:YES];
        
        [self.pauseResumeButton setTitle:@"PAUSE" forState:UIControlStateNormal];
    }
    
    self.isPaused = !self.isPaused;
    
}


@end
