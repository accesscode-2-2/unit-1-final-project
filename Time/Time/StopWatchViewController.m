//
//  StopWatchViewController.m
//  Time
//
//  Created by Jason Wang on 8/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopWatchViewController.h"


@interface StopWatchViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (weak, nonatomic) IBOutlet UIButton *startStopButton;

@property (weak, nonatomic) IBOutlet UIButton *labResetButton;

@property (nonatomic) BOOL running;

@property (nonatomic) BOOL resetLab;

@property (nonatomic) NSTimeInterval startTime;

@property (nonatomic) NSTimeInterval currentTime;

@property (nonatomic) NSTimeInterval lapCurrentTime;

@property (nonatomic) NSTimeInterval labInitTime;

@property (nonatomic) NSTimeInterval secondsAlreadyRun;

@property (nonatomic) NSTimeInterval secondsAlreadyRunLap;

@property (nonatomic) NSMutableArray *labsTimes;

@property (nonatomic) NSDate *startDate;

@property (nonatomic) NSDate *lapStartDate;

@property (weak, nonatomic) IBOutlet UILabel *labTimeLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation StopWatchViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.labResetButton.enabled = NO;
    self.timerLabel.text = @"00:00.00";
    self.labTimeLabel.text = @"00:00.00";
    self.running = NO;
    self.labsTimes = [[NSMutableArray alloc] init];

}

- (IBAction)startButtonAction:(UIButton *)sender {
    if (self.running == NO) {
        self.running = YES;
        self.startDate = [[NSDate alloc] init];
        self.lapStartDate = [[NSDate alloc] init];
        self.startTime = [NSDate timeIntervalSinceReferenceDate];
        self.labInitTime = [NSDate timeIntervalSinceReferenceDate];
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
        [self.labResetButton setTitle:@"Lap" forState:UIControlStateNormal];
        self.labResetButton.enabled = YES;
        [self timeIncrement];
        [self labtimeIncrement];
    } else {
        self.secondsAlreadyRun += [[NSDate date]timeIntervalSinceDate: self.startDate];
        self.secondsAlreadyRunLap += [[NSDate date]timeIntervalSinceDate:self.lapStartDate];
        self.startDate = [[NSDate alloc] init];
        self.lapStartDate = [[NSDate alloc] init];
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        [self.labResetButton setTitle:@"Reset" forState:UIControlStateNormal];
        self.running = NO;
        [self labtimeIncrement];

    }
    
}

- (IBAction)labResetButtonAction:(UIButton *)sender {
    
    self.secondsAlreadyRunLap = 0.0;
    self.labInitTime = 0.0;
    self.lapCurrentTime = 0.0;
    
    if (self.running == YES) {
        // lab button clicked
        
        [self.labsTimes insertObject:self.labTimeLabel.text atIndex:0];

        
        self.labTimeLabel.text = @"00:00.00";
        self.resetLab = YES;
        [self labtimeIncrement];
        [self.tableView reloadData];
        
    } else {
        //reset action here
        
        [self.labsTimes removeAllObjects];
        [self.tableView reloadData];
        self.secondsAlreadyRun = 0.0;
        self.currentTime = 0.0;
        self.startTime = 0.0;
        self.timerLabel.text = @"00:00.00";
        self.labTimeLabel.text = @"00:00.00";
    }
}



- (void)labtimeIncrement {
    if (self.running == NO)
        return;
        
    int labMins;
    int labSecs;
    int labFraction;
    
    if (self.resetLab == YES){
        self.labInitTime = [NSDate timeIntervalSinceReferenceDate];
        self.resetLab = NO;
    }
    
    self.lapCurrentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval lapElapsed = self.secondsAlreadyRunLap + self.lapCurrentTime - self.labInitTime;
    

    labMins = (int) (lapElapsed / 60.0);
    lapElapsed -= labMins * 60;
    labSecs = (int) (lapElapsed);
    lapElapsed -= labSecs;
    labFraction = lapElapsed * 100.0;
    
    self.labTimeLabel.text = [NSString stringWithFormat:@"%02u:%02u.%02u", labMins, labSecs, labFraction];
    
    [self performSelector:@selector(labtimeIncrement) withObject:self afterDelay:0.01];
}


- (void)timeIncrement {
    if (self.running == NO) return;
    
    self.currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = self.secondsAlreadyRun + self.currentTime - self.startTime;
    
    int mins = (int) (elapsed / 60.0);
    elapsed -= mins * 60;
    int secs = (int) (elapsed);
    elapsed -= secs;
    int fraction = elapsed * 100.0;
    
    self.timerLabel.text = [NSString stringWithFormat:@"%02u:%02u.%02u", mins, secs, fraction];
    
    [self performSelector:@selector(timeIncrement) withObject:self afterDelay:0.01];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.labsTimes.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *time = self.labsTimes[indexPath.row];
    cell.textLabel.text = time;
    
    return cell;
    
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
