//
//  StopwatchTableViewController.m
//  Time
//
//  Created by Eric Sze on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopwatchViewController.h"
#import <QuartzCore/QuartzCore.h>

@import QuartzCore;


@interface StopwatchViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *lapButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *start;


// Lap Time Properties
@property (weak, nonatomic) IBOutlet UILabel *lapTimeLabel;

@property (nonatomic) NSMutableArray *laps;


@property (nonatomic) NSTimeInterval startTime;
@property (nonatomic) NSTimeInterval totalTime;
@property (nonatomic) NSTimeInterval currentTime;
@property (nonatomic) NSTimeInterval elapsed;
@property (nonatomic) NSDate *startTimeCount;
@property (nonatomic) NSTimeInterval previousTimeCount;


@property (nonatomic) NSTimeInterval startLapTime;
@property (nonatomic) NSTimeInterval elapsedLapTime;
@property (nonatomic) NSTimeInterval previousLapTime;
@property (nonatomic) NSTimeInterval lapTime;
@property (nonatomic) NSDate *startLapCount;
@property (nonatomic) NSTimeInterval previousLapCount;

@property (weak, nonatomic) IBOutlet UIView *leftCircle;
@property (weak, nonatomic) IBOutlet UIView *rightCircle;

@end

@implementation StopwatchViewController

BOOL running;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"track"];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
    self.scrollView.contentSize = backgroundImage.size;
    [self.scrollView addSubview:backgroundImageView];
    
    [self.lapButton setEnabled:NO];
    [self.lapButton setTitleColor: [UIColor lightGrayColor]forState:UIControlStateNormal];
    [self.resetButton setHidden:YES];
    
    self.laps = [[NSMutableArray alloc] init];
    
    self.timerLabel.text = @"00:00.00";
    self.lapTimeLabel.text = @"00:00.00";
    
    self.leftCircle.layer.cornerRadius = 34.5;
    self.leftCircle.layer.masksToBounds = YES;
    self.rightCircle.layer.cornerRadius = 34.5;
    self.rightCircle.layer.masksToBounds = YES;
}

- (IBAction)lapButton:(id)sender {
    
    [self.laps addObject:self.lapTimeLabel.text];
    self.lapTimeLabel.text = @"00:00.00";
    self.startLapTime = [NSDate timeIntervalSinceReferenceDate];
    self.previousLapCount = 0.0;
    self.startLapCount = [[NSDate alloc]init];
    [self updateLapTime];
    [self.tableView reloadData];

    

}

- (IBAction)resetButton:(UIButton *)sender {
    
    
    [self.resetButton setHidden:YES];
    [self.lapButton setHidden:NO];
    [self.lapButton setEnabled:NO];
    [self.lapButton setTitleColor: [UIColor lightGrayColor]forState:UIControlStateNormal];
    [self.laps removeAllObjects];
    [self.tableView reloadData];
    
    self.timerLabel.text = @"00:00.00";
    self.lapTimeLabel.text = @"00:00.00";
    
    self.previousTimeCount = 0.0;
    self.previousLapCount = 0.0;
}

- (IBAction)start:(UIButton *)sender {

    
    if (running == false) {
        // start timer
        running = true;
        
        self.lapButton.enabled = YES;
        [self.lapButton setTitleColor: [UIColor blackColor]forState:UIControlStateNormal];
        
        self.startTime = [NSDate timeIntervalSinceReferenceDate];
        self.startTimeCount = [[NSDate alloc]init];
        self.startLapTime = [NSDate timeIntervalSinceReferenceDate];
        self.startLapCount = [[NSDate alloc]init];
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self updateTime];
        [self updateLapTime];
        
        [self.resetButton setHidden:YES];
        [self.lapButton setHidden:NO];
        
    } else {
        // stop timer
        self.previousTimeCount += [[NSDate date]timeIntervalSinceDate:self.startTimeCount];
        self.previousLapCount += [[NSDate date]timeIntervalSinceDate:self.startLapCount];
        [sender setTitle:@"Start" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        running = false;
        
        [self.lapButton setHidden:YES];
        [self.resetButton setHidden:NO];
    }
    
}

- (void)updateTime {
    if (running == false) return;
    
    // calculate elapsed time
    self.currentTime = [NSDate timeIntervalSinceReferenceDate];
    self.elapsed = self.previousTimeCount + self.currentTime - self.startTime;
    

    // extract out the minutes, seconds, and fraction of seconds from elapsed time:
    int mins = (int) (self.elapsed / 60.0);
    self.elapsed -= mins * 60;
    int secs = (int) (self.elapsed);
    self.elapsed -= secs;
    int fraction = self.elapsed * 100.0;
    
    // update our label using a format of 0:00.0
    self.timerLabel.text = [NSString stringWithFormat: @"%02u:%02u.%02u", mins, secs, fraction];
    // call updateTime again after 0.1 seconds
    [self performSelector:@selector(updateTime) withObject:self afterDelay:0.01];
}

- (void)updateLapTime {
    if (running == false) return;
    
    // calculate elapsed time
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    self.elapsedLapTime = self.previousLapCount + currentTime - self.startLapTime;

    
    // extract out the minutes, seconds, and fraction of seconds from elapsed time:
    int mins = (int) (self.elapsedLapTime / 60.0);
    self.elapsedLapTime -= mins * 60;
    int secs = (int) (self.elapsedLapTime);
    self.elapsedLapTime -= secs;
    int fraction = self.elapsedLapTime * 100.0;

    self.lapTimeLabel.text =  [NSString stringWithFormat: @"%02u:%02u.%02u", mins, secs, fraction];

    

    // call updateTime again after 0.1 seconds
    [self performSelector:@selector(updateLapTime) withObject:self afterDelay:0.01];
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
