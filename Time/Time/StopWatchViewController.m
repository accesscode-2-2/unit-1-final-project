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

@property (nonatomic) BOOL running;
@property (nonatomic) BOOL LapTapped;

@property (strong, nonatomic) IBOutlet UILabel *StopwatchRunningLabel;
@property (strong, nonatomic) IBOutlet UILabel *recentLapRunning;

@property (strong, nonatomic) IBOutlet UIButton *startStopButton;
@property (strong, nonatomic) IBOutlet UIButton *resetLapButton;

@property (nonatomic) NSTimeInterval firstStartTime;
@property (nonatomic) NSTimeInterval timeInterval;
@property (nonatomic) NSTimeInterval timeAtThisMoment;
@property (nonatomic) NSTimeInterval lapFirstInitTime;
@property (nonatomic) NSTimeInterval lapTimeAtThisMoment;
@property (nonatomic) NSTimeInterval lapTimeInterval;
@property (nonatomic) NSTimeInterval elapsed;
@property (nonatomic) NSTimeInterval lapElapsed;

@property (nonatomic) NSDate *saveDate;
@property (nonatomic) NSDate *lapSaveDate;

@end

@implementation StopWatchViewController
NSString *initialTime = @"00:00.00";
NSInteger minutes;
NSInteger seconds;
NSInteger miliseconds;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.StopwatchRunningLabel.text = initialTime; //set the text to the label
    self.recentLapRunning.text = initialTime; //set the text to the label
    self.LapArray = [[NSMutableArray alloc]init]; //initialize array
    self.running = NO;
    
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
    
    // this adds ringtone sound
    NSString *path = [NSString stringWithFormat:@"%@/clock-ticking-5.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    // Create audio player object and initialize with URL to sound
    _clock = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    NSString *path2 = [NSString stringWithFormat:@"%@/ding.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl2 = [NSURL fileURLWithPath:path2];
    _LapSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl2 error:nil];
}

#pragma mark - Timers

- (void)StopwatchTimer {
    if (self.running == NO)
        return;
    self.timeAtThisMoment = [NSDate timeIntervalSinceReferenceDate];
    self.elapsed = self.timeInterval + self.timeAtThisMoment - self.firstStartTime;
    
    minutes = (NSInteger) (_elapsed / 60.0);
    _elapsed -= minutes * 60;
    seconds = (NSInteger) (_elapsed);
    _elapsed -= seconds;
    miliseconds = _elapsed * 100.0;
    
    self.StopwatchRunningLabel.text = [NSString stringWithFormat:@"%02ld:%02ld.%02ld", (long)minutes, (long)seconds, (long)miliseconds];
    //call it after delay
    [self performSelector:@selector(StopwatchTimer) withObject:self afterDelay:0.01];
}

- (void)LapTimer {
    if (self.running == NO)
        return;
    else if (self.LapTapped == YES){
        self.lapFirstInitTime = [NSDate timeIntervalSinceReferenceDate];
        self.LapTapped = NO;
    }
    
    self.lapTimeAtThisMoment = [NSDate timeIntervalSinceReferenceDate];
    _lapElapsed = self.lapTimeInterval + self.lapTimeAtThisMoment - self.lapFirstInitTime;
    
    minutes = (NSInteger) (_lapElapsed / 60.0);
    _lapElapsed -= minutes * 60;
    seconds = (NSInteger) (_lapElapsed);
    _lapElapsed -= seconds;
    miliseconds = _lapElapsed * 100.0;
    
    self.recentLapRunning.text = [NSString stringWithFormat:@"%02ld:%02ld.%02ld", (long)minutes, (long)seconds, (long)miliseconds];
    
    [self performSelector:@selector(LapTimer) withObject:self afterDelay:0.01];
}




#pragma mark - Buttons

- (IBAction)startStopButtonTapped:(UIButton *)sender {
    
    if (self.running) { //stop Tapped
        [_clock stop]; //stop sound
        
        self.timeInterval += [[NSDate date]timeIntervalSinceDate: self.saveDate];
        self.saveDate = [[NSDate alloc] init];
        self.lapTimeInterval += [[NSDate date]timeIntervalSinceDate:self.lapSaveDate];
        self.lapSaveDate = [[NSDate alloc] init];
        
        //self.resetLapButton.enabled = YES;
        
        /******  Interface layout *****/
        [self.resetLapButton setTitle:@"Reset" forState:UIControlStateNormal];
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        self.startStopButton.backgroundColor = [UIColor colorWithRed:0.31 green:0.60 blue:0.19 alpha:1.0];
        self.running = NO; // timer is not running
        
        [self LapTimer]; //call Lap Timer
        
    } else { // start Tapped
        [_clock play];
        self.running = YES; // timer state: stopped
        self.saveDate = [[NSDate alloc] init];
        self.firstStartTime = [NSDate timeIntervalSinceReferenceDate];
        self.lapSaveDate = [[NSDate alloc] init];
        self.lapFirstInitTime = [NSDate timeIntervalSinceReferenceDate];
        
        /******  Interface layout *****/
        
        [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
        self.startStopButton.backgroundColor = [UIColor redColor];
        [self.resetLapButton setTitle:@"Lap" forState:UIControlStateNormal];
        self.resetLapButton.enabled = YES;
        [self StopwatchTimer]; //call the timer
        [self LapTimer]; //call Lap Timer
    }
}

- (IBAction)resetLapButtonTapped:(UIButton *)sender {
    
    //Lap or reset, both cases need to reset lap info
    self.lapTimeInterval = 0;
    self.lapFirstInitTime = 0;
    self.lapTimeAtThisMoment = 0;
    
    if (self.running) { // lab button tapped
        [_LapSound stop];
        [_LapSound play];
        self.LapTapped = YES;
        [self.LapArray insertObject:self.recentLapRunning.text atIndex:0];
        self.recentLapRunning.text = initialTime; //change label text
        [self LapTimer]; //call Lap Timer
        [self.LapTableView reloadData];
        
        
    } else {//reset tapped
        //reset stopwatch info
        self.timeInterval = 0;
        self.timeAtThisMoment = 0;
        self.firstStartTime = 0;
        [self.LapArray removeAllObjects];// reset lap array
        [self.LapTableView reloadData];// reload table view
        self.StopwatchRunningLabel.text = initialTime; //change label text
        self.recentLapRunning.text = initialTime; //change label text
    }
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
    
    
    
    //NSLog(@"%lu", self.LapArray.count);
    
       if (self.LapArray.count == 1) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.textColor = [UIColor redColor];
            NSLog(@"aa");
        }
    //    if (([self.LapArray objectAtIndex:1] != nil) && ([self.LapArray objectAtIndex:0] < [self.LapArray objectAtIndex:1])) {
    //
    //        cell.textLabel.textColor = [UIColor blueColor];
    //        cell.detailTextLabel.textColor = [UIColor blueColor];
    //    }
    
    
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"Lap %ld",[self.LapArray count] - indexPath.row];
    
    cell.detailTextLabel.text = self.LapArray[indexPath.row];
    //cell.textLabel.text = self.LapArray[indexPath.row];
    
    return cell;
}





@end
