//
//  TimerViewController.m
//  Time
//
//  Created by Artur Lan on 8/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerViewController.h"
#import "DetailViewController.h"
#import "PresetTime.h"


@interface TimerViewController () 


@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerView;
@property (nonatomic) NSTimeInterval countDownDuration;
@property (weak, nonatomic) IBOutlet UILabel *timer;
@property (nonatomic) NSTimer *countdownTimer;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *resumeButton;
@property (nonatomic) NSTimeInterval totalTime;
@property (nonatomic) NSDate *startTime;

@end

@implementation TimerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timers = [[NSMutableArray alloc] init];

    
    [self.startButton setHidden:NO];
    

    [self.cancelButton setHidden:YES];
    [self.resumeButton setHidden:YES];

    
    [self.timer setHidden:YES];
    // Create a new date with the current time
    // Split up the date components
    
    NSInteger seconds = 60;
    
    [self.pickerView setDatePickerMode:UIDatePickerModeCountDownTimer];
    [self.pickerView setCountDownDuration:seconds];
    
}



- (IBAction)pressButton:(id)sender {
    [self.startButton setHidden:YES];
    [self.cancelButton setHidden:NO];
    
    if(sender == self.startButton){
        [self.timer setHidden:NO];
        [self.pickerView setHidden:YES];
        

        self.countdownTimer = [NSTimer timerWithTimeInterval:60/60 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.countdownTimer forMode:NSRunLoopCommonModes];
        self.countDownDuration = self.pickerView.countDownDuration;
        [self updateTimeLabel];
    }
}


- (IBAction)cancelButton:(id)sender {
    [self.startButton setHidden:NO];
    [self.cancelButton setHidden:YES];
    [self.pickerView setHidden:NO];
    [self.timer setHidden:YES];
    [self.countdownTimer invalidate];
    
}
- (IBAction)pauseButton:(id)sender {
    [self.pauseButton setHidden:YES];
    [self.resumeButton setHidden:NO];
    
    [self.countdownTimer invalidate];

}
- (IBAction)resumeButton:(id)sender {
    [self.pauseButton setHidden:NO];
    [self.resumeButton setHidden:YES];
    
    self.countdownTimer = [NSTimer timerWithTimeInterval:60/60 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.countdownTimer forMode:NSRunLoopCommonModes];

}

- (void)countDown:(NSTimer *) countdownTimer {
    self.countDownDuration = self.countDownDuration - 1;
    [self updateTimeLabel];
}

- (void)updateTimeLabel {
    if (self.countDownDuration <= 0) {
        [self.countdownTimer invalidate];
    }
    int secondsCount = self.countDownDuration;
    int minutes = secondsCount / 60;
    int seconds = secondsCount - (minutes * 60);
    
    self.timer.text = [NSString stringWithFormat:@"%02u:%02u", minutes, seconds];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.timers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"preset" forIndexPath:indexPath];
    
    PresetTime *time;
    
    time = [self.timers objectAtIndex:indexPath.row];
    
    cell.textLabel.text = time.nameOfTask;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lg", time.timeOfTask];
    
    
    return cell;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UINavigationController *navigationController = segue.destinationViewController;
    DetailViewController *detailViewController = [navigationController.viewControllers objectAtIndex:0];
    detailViewController.previousViewController = self;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    PresetTime *time;
    
    time = [self.timers objectAtIndex:indexPath.row];
    
    self.pickerView.countDownDuration = time.timeOfTask * 60;
    self.countDownDuration = time.timeOfTask * 60;
    
    [self.pickerView setHidden:YES];
    [self.timer setHidden:NO];
    [self.startButton setHidden:YES];
    [self.cancelButton setHidden:NO];
    self.countdownTimer = [NSTimer timerWithTimeInterval:60/60 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.countdownTimer forMode:NSRunLoopCommonModes];

    
    [self updateTimeLabel];
    
    
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
