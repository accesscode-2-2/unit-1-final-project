//
//  StopwatchTableViewController.m
//  Time
//
//  Created by Eric Sze on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopwatchViewController.h"
//@import QuartzCore.CADisplayLink;
@import QuartzCore;

@interface StopwatchViewController ()

@property (nonatomic) NSMutableArray *laps;
@property (weak, nonatomic) IBOutlet UIButton *lapButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) CADisplayLink *displayLink;

@property(readonly, nonatomic) CFTimeInterval duration;
@property(nonatomic) NSInteger frameInterval;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *start;
//new addition
@property (nonatomic) NSTimeInterval totalTime;

@property (weak, nonatomic) IBOutlet UILabel *lapTimeLabel;

@property (nonatomic) NSTimeInterval elapsedLapTime;

@property (nonatomic) NSTimeInterval previousLapTime;

@property (nonatomic) NSTimeInterval lapTime;


@end

@implementation StopwatchViewController

BOOL running;
NSTimeInterval startTime;
//NSTimeInterval startTimeNow;

- (IBAction)lapButton:(id)sender {
    
    //NSTimeInterval totalTime - ;
    
//    NSTimeInterval currentTimeNow = [NSDate timeIntervalSinceReferenceDate];
//    NSTimeInterval elapsedTimeNow;
//    NSTimeInterval lapTimeNow = currentTimeNow - elapsedTimeNow;
//    self.lapTimeLabel.text = [NSString stringWithFormat:@"%f",lapTimeNow];
//
//    NSString *lap = self.lapTimeLabel.text;
//
//        [self.laps addObject:lap];
//
    
    
    
    //NSString *currentLapTime = self.timerLabel.text;
    // lap = current time - previousLapTime
    
    //new line added thursday 8-27
    NSLog(@"%f", self.totalTime - self.previousLapTime);
    
    self.lapTime = self.totalTime - self.previousLapTime;
    
    ///////
 //   self.lapTimeLabel.text = [NSString stringWithFormat:@"%f", self.lapTime];

    NSString *correctLap = self.lapTimeLabel.text;
    [self.laps addObject:correctLap];

    [self.tableView reloadData];
    
    //new line added thursday 8-27
    self.previousLapTime = self.totalTime;
//    self.lapTimeLabel.text = [NSString stringWithFormat:@"%f", self.previousLapTime];
    
    

}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];

    self.laps = [[NSMutableArray alloc] init];
    
    self.timerLabel.text = @"00:00:00";
    
    self.lapTimeLabel.text = @"00:00:00";
}

- (IBAction)start:(UIButton *)sender {

    
    if (running == false) {
        // start timer
        running = true;
        startTime = [NSDate timeIntervalSinceReferenceDate];
        [sender setTitle:@"STOP" forState:UIControlStateNormal];
        [self updateTime];
    } else {
        // stop timer
        [sender setTitle:@"START" forState:UIControlStateNormal];
        running = false;
    }
    
}

- (void)updateTime {
    if (running == false) return;
    
    // calculate elapsed time
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = + currentTime - startTime;
    
    self.totalTime += elapsed;
    startTime = currentTime;
    
    // extract out the minutes, seconds, and fraction of seconds from elapsed time:
    int mins = (int) (elapsed / 60.0);
    elapsed -= mins * 60;
    int secs = (int) (elapsed);
    elapsed -= secs;
    int fraction = elapsed * 100.0;
    //////
    self.elapsedLapTime = currentTime - startTime;
    //////
    //Work at end of thursday class
    self.lapTimeLabel.text = [NSString stringWithFormat:@"%02d:%f",secs, self.totalTime - self.previousLapTime];
    
    self.timerLabel.text = [NSString stringWithFormat:@"%f", self.totalTime];
    
    // update our label using a format of 0:00.0
//    self.timerLabel.text = [NSString stringWithFormat: @"%02u:%02u:%02u", mins, secs, fraction];
    
    // call updateTime again after 0.1 seconds
    [self performSelector:@selector(updateTime) withObject:self afterDelay:0.01];
}

#pragma mark - tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return self.laps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    
//    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.laps.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Lap %ld", [self.laps count] - (long)indexPath.row];
    cell.detailTextLabel.text = self.laps[[self.laps count] -1 - indexPath.row];
    
//    cell.textLabel.text = [NSString stringWithFormat:@"Lap %ld", (long)indexPath.row];
//    cell.detailTextLabel.text = self.laps[indexPath.row];
    
    
    return cell;
}

@end
