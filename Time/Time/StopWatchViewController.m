//
//  StopWatchViewController.m
//  Time
//
//  Created by Diana Elezaj on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopWatchViewController.h"
#import <QuartzCore/QuartzCore.h>
#define Digital(s) [UIFont fontWithName:@"digital-7.ttf" size:s]
#import <AVFoundation/AVFoundation.h> // this allows us to include sounds!


@interface StopWatchViewController () <UITableViewDataSource, UITabBarDelegate>
{
    AVAudioPlayer *_clock;
    AVAudioPlayer *_LapSound;
}
@property (strong, nonatomic) IBOutlet UITableView *LapTableView;
@property (nonatomic) BOOL LapTapped;
@property (nonatomic) BOOL SaveLappedTime;

@property (nonatomic) NSMutableArray *LapArray;
@property (nonatomic) NSMutableArray *reversedLaps;

@property (strong, nonatomic) IBOutlet UILabel *StopwatchRunningLabel;
@property (strong, nonatomic) IBOutlet UILabel *recentLapRunning;

@property (strong, nonatomic) IBOutlet UIButton *startStopButton;
@property (strong, nonatomic) IBOutlet UIButton *resetLapButton;

@property (nonatomic) NSTimer *runningStopWatchTimer;
@property (nonatomic) NSTimer *LapTimer;
@property (nonatomic) NSTimer *runStopwatchTimer;
@property (nonatomic) NSDate *startTime;
@property (nonatomic) NSDate *lapStartTime;

@property (nonatomic) NSTimeInterval LapTotalSessionTime;
@property (nonatomic) NSTimeInterval totalSessionTime;
@property (nonatomic) NSTimeInterval totalTime;
@property (nonatomic) NSTimeInterval distance;

@end

@implementation StopWatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.LapArray = [[NSMutableArray alloc]init];
    
    self.LapTableView.dataSource = self;
    self.LapTableView.delegate = self;
    self.SaveLappedTime = NO;
    
    /******  Interface layout *****/
    [self.startStopButton.titleLabel  isEqual: @"Start"];
    self.startStopButton.layer.cornerRadius = 10;
    self.startStopButton.clipsToBounds = YES;
    self.startStopButton.backgroundColor = [UIColor colorWithRed:0.31 green:0.60 blue:0.19 alpha:1.0];
    
    [self.resetLapButton.titleLabel  isEqual: @"Reset"];
    self.resetLapButton.layer.cornerRadius = 10;
    self.resetLapButton.clipsToBounds = YES;
    self.resetLapButton.backgroundColor = [UIColor grayColor];
    self.resetLapButton.enabled = NO;
    
    self.LapTapped = NO;
    
#pragma mark - Ringtones
    
    // this adds ringtone sound
    NSString *path = [NSString stringWithFormat:@"%@/clock-ticking-5.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    // Create audio player object and initialize with URL to sound
    _clock = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    
    NSString *path2 = [NSString stringWithFormat:@"%@/ding.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl2 = [NSURL fileURLWithPath:path2];
    // Create audio player object and initialize with URL to sound
    _LapSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl2 error:nil];
    
}

#pragma mark - Timers

- (void)timerFired:(NSTimer *)runningStopWatchTimer {
    
    // get the current time
    NSDate *now = [[NSDate alloc] init];
    
    self.totalSessionTime = [now timeIntervalSinceDate:self.startTime];
    self.distance =  self.totalTime + self.totalSessionTime;
    
    NSTimeInterval minutes = floor(self.distance / 60.0);
    self.distance -= (minutes * 60);
 
    self.StopwatchRunningLabel.text = [NSString stringWithFormat:@"%.f:%0.2f", minutes, self.distance];
    
}

- (void)timerLapFired:(NSTimer *)LapTimer {
    
    // get the current time
    NSDate *now2 = [[NSDate alloc] init];
    
    self.LapTotalSessionTime = [now2 timeIntervalSinceDate:self.lapStartTime];
    self.distance =  self.totalTime + self.LapTotalSessionTime;
    
    NSTimeInterval minutes = floor(self.distance / 60.0);
     self.distance -= (minutes * 60);
    
    if (self.LapTapped == NO)
        self.recentLapRunning.text = [NSString stringWithFormat:@"%.f:%0.2f", minutes,self.distance];
    else if (self.LapTapped == YES)
        self.recentLapRunning.text = [NSString stringWithFormat:@"%.f:%0.2f", minutes, self.LapTotalSessionTime];
 
}

#pragma mark - Buttons

- (IBAction)startStopButtonTapped:(UIButton *)sender {
//    if ([self.recentLapRunning.text isEqualToString:@"0:00.0"]) {
    
    self.lapStartTime = [[NSDate alloc] init];
    
    //check Label's text
    NSString *startStopActualLabel =  self.startStopButton.titleLabel.text;
    if ([startStopActualLabel isEqualToString:@"Start"] ) {
        [_clock play];
        // set self.startTime to now
        self.startTime = [[NSDate alloc] init];
        
        // setup timer
        self.runningStopWatchTimer = [NSTimer timerWithTimeInterval:1/60.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        
        // add timer to the run loop
        [[NSRunLoop currentRunLoop] addTimer:self.runningStopWatchTimer forMode:NSRunLoopCommonModes];
 
        // setup timer
        self.LapTimer = [NSTimer timerWithTimeInterval:1/60.0 target:self selector:@selector(timerLapFired:) userInfo:nil repeats:YES];
        
        // add timer to the run loop
        [[NSRunLoop currentRunLoop] addTimer:self.LapTimer forMode:NSRunLoopCommonModes];
        
        /******  Interface layout *****/
        self.resetLapButton.enabled = YES;
        [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
        [self.resetLapButton setTitle:@"Lap" forState:UIControlStateNormal];
        self.startStopButton.backgroundColor = [UIColor redColor];
     }
    
    else if ([startStopActualLabel isEqualToString:@"Stop"] ) {
        [_clock stop];

        // keep track of the total amount of time that this stopwatch has been running
        self.totalTime = self.totalTime + self.totalSessionTime;
        
        // stop the timer
        [self.runningStopWatchTimer invalidate];
        [self.LapTimer invalidate];
        /******  Interface layout *****/
        [self.resetLapButton setTitle:@"Reset" forState:UIControlStateNormal];
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        self.startStopButton.backgroundColor = [UIColor colorWithRed:0.31 green:0.60 blue:0.19 alpha:1.0];
    }
}

- (IBAction)resetLapButtonTapped:(UIButton *)sender {
    NSString *resetLapActualLabel =  self.resetLapButton.titleLabel.text;
    if ([resetLapActualLabel isEqualToString:@"Reset"]) {
        [_clock stop];

        [[self runningStopWatchTimer] invalidate];
        self.totalSessionTime = 0;
        self.totalTime = 0;
        self.LapTotalSessionTime = 0;
        
        [self.LapArray removeAllObjects];
        [self.reversedLaps removeAllObjects];
        [self.LapTableView reloadData];
        
        /******  Interface layout *****/
        self.StopwatchRunningLabel.text = @"0:00.0";
        self.recentLapRunning.text = @"0:00.0";
        [self.resetLapButton setTitle:@"Lap" forState:UIControlStateNormal];
        self.resetLapButton.enabled = YES;
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        self.startStopButton.backgroundColor = [UIColor colorWithRed:0.31 green:0.60 blue:0.19 alpha:1.0];
}
  else if ([resetLapActualLabel isEqualToString:@"Lap"]) {
      [_LapSound stop];
      [_LapSound play];
      
      self.lapStartTime = [[NSDate alloc] init];
      self.SaveLappedTime = YES;
      
      [self.LapArray addObject:self.recentLapRunning.text];
      
      [self.LapTableView reloadData];
    
      [[self LapTimer] invalidate];
      
      // setup timer
      self.LapTimer = [NSTimer timerWithTimeInterval:1/60.0 target:self selector:@selector(timerLapFired:) userInfo:nil repeats:YES];
      
      // add timer to the run loop
      [[NSRunLoop currentRunLoop] addTimer:self.LapTimer forMode:NSRunLoopCommonModes];
      
      self.LapTapped = NO;
  }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return self.LapArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    
    self.reversedLaps = [NSMutableArray arrayWithCapacity:[self.LapArray count]];
    NSEnumerator*   reverseEnumerator = [self.LapArray reverseObjectEnumerator];
    for (id object in reverseEnumerator)
    {
        [self.reversedLaps addObject:object];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Lap %ld",[self.reversedLaps count] - indexPath.row];
    cell.detailTextLabel.text = self.reversedLaps[indexPath.row];

 
    return cell;
}





@end
