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
@property (nonatomic) NSMutableArray *LapArray;

@property (nonatomic) BOOL firstTimeRunning;

@property (nonatomic) BOOL running;
@property (nonatomic) BOOL LapTapped;

@property (nonatomic) NSInteger timeMilliSec;
@property (nonatomic) NSInteger lapMilliSec;


@property (strong, nonatomic) NSTimer *StopwatchTimer; 
@property (strong, nonatomic) NSTimer *lapTimer;

@property (strong, nonatomic) IBOutlet UILabel *StopwatchRunningLabel;
@property (strong, nonatomic) IBOutlet UILabel *recentLapRunning;

@property (strong, nonatomic) IBOutlet UIButton *startStopButton;
@property (strong, nonatomic) IBOutlet UIButton *resetLapButton;

 @property (nonatomic) NSInteger fastestLapIndex;

@end

@implementation StopWatchViewController
NSString *initialTime = @"00:00:00";
NSInteger minutes;
NSInteger seconds;
NSInteger milliseconds;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.StopwatchRunningLabel.text = initialTime; //set the text to the label
    self.recentLapRunning.text = initialTime; //set the text to the label
    self.LapArray = [[NSMutableArray alloc]init]; //initialize array
    self.running = NO;
    self.firstTimeRunning = YES;
    self.LapTapped = YES;
    self.LapTableView.delegate = self;
    self.LapTableView.dataSource = self;
    
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
    
#pragma mark - Ringtones
    
    NSString *path = [NSString stringWithFormat:@"%@/clock-ticking-5.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    _clock = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    NSString *path2 = [NSString stringWithFormat:@"%@/ding.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl2 = [NSURL fileURLWithPath:path2];
    _LapSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl2 error:nil];
}

#pragma mark - Timers

- (void)callStopwatchTimer
{
    self.timeMilliSec += 1;
    
    minutes = self.timeMilliSec / 6000;
    self.timeMilliSec -= minutes * 6000;
    
    seconds =   self.timeMilliSec/100 ;
    
    milliseconds = self.timeMilliSec % 100;
    
    self.StopwatchRunningLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)minutes, (long)seconds, (long)milliseconds];
}

- (void)callLapTimer
{
    self.lapMilliSec += 1;
    
    minutes = self.lapMilliSec / 6000;
    self.lapMilliSec  -= minutes * 6000;
    
    seconds =   self.lapMilliSec/100 ;
    
    milliseconds = self.lapMilliSec % 100;
    
    self.recentLapRunning.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)minutes, (long)seconds, (long)milliseconds];
}




#pragma mark - Buttons

- (IBAction)startStopButtonTapped:(UIButton *)sender {
    
    if(self.firstTimeRunning){ //start tapped for the first time
        NSLog(@"first");
        [_clock play];
        self.firstTimeRunning = NO;
        self.LapTapped = YES;
        self.running = NO;
        self.resetLapButton.enabled = YES;
        
        self.StopwatchTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(callStopwatchTimer) userInfo:nil repeats:YES];
        self.lapTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(callLapTimer) userInfo:nil repeats:YES];
        
        /******  Interface layout *****/
        [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
        self.startStopButton.backgroundColor = [UIColor redColor];
        [self.resetLapButton setTitle:@"Lap" forState:UIControlStateNormal];
        
    }

    else if(self.running == NO){ //stop tapped

        [_clock stop];
        self.running = YES;
        self.LapTapped = NO;
        
        [self.StopwatchTimer invalidate];
        [self.lapTimer invalidate];
        
        /******  Interface layout *****/
        [self.resetLapButton setTitle:@"Reset" forState:UIControlStateNormal];
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        self.startStopButton.backgroundColor = [UIColor colorWithRed:0.31 green:0.60 blue:0.19 alpha:1.0];
    }
    
    else { //start tapped (not for the first time)

        self.running = NO;
        [_clock play];
        self.LapTapped = YES;
        self.resetLapButton.enabled = YES;

        self.StopwatchTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(callStopwatchTimer) userInfo:nil repeats:YES];
        self.lapTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(callLapTimer) userInfo:nil repeats:YES];
        
        /******  Interface layout *****/
        [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
        self.startStopButton.backgroundColor = [UIColor redColor];
        [self.resetLapButton setTitle:@"Lap" forState:UIControlStateNormal];
    }
}


- (IBAction)resetLapButtonTapped:(UIButton *)sender {
    
    if(self.LapTapped == NO){  //reset tapped
        
        self.firstTimeRunning = YES;
        self.resetLapButton.enabled = NO;
        [self.StopwatchTimer invalidate];
        [self.lapTimer invalidate];
        [self.LapArray removeAllObjects];
        [self.LapTableView reloadData];
        self.timeMilliSec = 0;
        self.lapMilliSec = 0;
        self.StopwatchTimer = nil;
        self.lapTimer = nil;
        self.StopwatchRunningLabel.text = initialTime; //change label text
        self.recentLapRunning.text = initialTime; //change label text
    }
    else { // lap tapped
        
        self.lapMilliSec = 0;
        
        [_LapSound stop];
        [_LapSound play];
        
        [self.LapArray insertObject:self.recentLapRunning.text atIndex:0];
        [self.LapTableView reloadData];
        self.recentLapRunning.text = initialTime; //change label text
        
        [self evaluateFastestLap];
    }
}
 
- (void)evaluateFastestLap {
    NSLog(@"still  ");
    if (self.LapArray.count == 1) {
        self.fastestLapIndex = 0;
        NSLog(@"still working on it");

    }
    
    
    
        
//    if (self.fastestLapIndex) {
//        
//        
//     }
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 }

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return self.LapArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stopwatchIdentifier" forIndexPath:indexPath];
    
    
    
    
    
//  NSArray *components = [@"01:01:00" componentsSeparatedByString:@":"];
//    NSArray *components = [self.LapArray[indexPath.row] componentsSeparatedByString:@":"];
//
//    NSInteger hours   = [[components objectAtIndex:0] integerValue];
//    NSInteger minutes = [[components objectAtIndex:1] integerValue];
//    NSInteger seconds = [[components objectAtIndex:2] integerValue];
//    NSInteger numberWithInteger = (hours * 60 * 60) + (minutes * 60) + seconds;
//    NSLog(@" %ld ", (long)numberWithInteger);
//    

    
    
    if (self.LapArray.count == 1) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    
//    
//    if (indexPath.row == self.fastestLapIndex) {
//        // set the color to red
//        cell.textLabel.textColor = [UIColor redColor];
//        cell.detailTextLabel.textColor = [UIColor redColor];
//    }
    
    
    
//    if (self.LapArray.count > 1) {
//        if ([self.LapArray objectAtIndex:0] < [self.LapArray objectAtIndex:1]) {
//            cell.textLabel.textColor = [UIColor redColor];
//            cell.detailTextLabel.textColor = [UIColor redColor];
//        }
//    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Lap %ld",[self.LapArray count] - indexPath.row];
    
    cell.detailTextLabel.text = self.LapArray[indexPath.row];
    
    return cell;
}

#pragma mark Cells color
- (void)tableView: (UITableView*)tableView
  willDisplayCell: (UITableViewCell*)cell
forRowAtIndexPath: (NSIndexPath*)indexPath
{
    cell.backgroundColor = indexPath.row % 2
    ? [UIColor colorWithRed:0.87 green:0.93 blue:0.98 alpha:1.0]
    : [UIColor whiteColor];
    
}



@end
