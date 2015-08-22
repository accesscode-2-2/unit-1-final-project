//
//  GOStopwatchViewController.m
//  unit-1-final-project
//
//  Created by Jamaal Sedayao on 8/21/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "GOStopwatchViewController.h"
#import "LapTimerTableViewCell.h"

@interface GOStopwatchViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSMutableArray *laps;
@property (nonatomic) NSMutableArray *numberOfLaps;
@property (nonatomic) NSInteger lapNumber;
@property (nonatomic, retain) NSDate* start;
@property (nonatomic) NSDate *mainDate;
@property (nonatomic) NSTimer *stopwatch;
@property (nonatomic) BOOL isRunning;
@property (nonatomic) BOOL isPause;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *stopwatchTimerLabel;
@property (nonatomic) NSTimer *mainStopwatch;
@property (weak, nonatomic) IBOutlet UILabel *mainStopwatchLabel;
@property (nonatomic, assign) NSTimeInterval pauseTime;
@property (nonatomic) LapTimerTableViewCell * model;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (nonatomic) float totalTime;
@property (nonatomic) NSDate *previousTime;

@end

@implementation GOStopwatchViewController

- (void)viewDidLoad {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.model = [[LapTimerTableViewCell alloc] init];
    
    [super viewDidLoad];
    
    self.laps = [[NSMutableArray alloc]init];
    
    self.start = [[NSDate alloc]init];
    
    self.numberOfLaps = [[NSMutableArray alloc]init];
    
}


- (IBAction)startStopwatchButton:(UIButton *)sender {
    
    self.stopwatch = [NSTimer scheduledTimerWithTimeInterval:1.0/100.0
                                                      target:self
                                                    selector:@selector(updateStopwatchTimer)
                                                    userInfo:nil repeats:YES];
    
    self.mainStopwatch = [NSTimer scheduledTimerWithTimeInterval:1.0/100.0
                                                          target:self
                                                        selector:@selector(updateMainStopwatchTimer)
                                                        userInfo:nil repeats:YES];
    
    self.previousTime = [[NSDate alloc] init];
    
}

-(void) updateMainStopwatchTimer {
    
    NSDate *currentTime = [[NSDate alloc] init];
    
    NSTimeInterval ellapsedTime = [currentTime timeIntervalSinceDate: self.previousTime];
    self.previousTime = currentTime;

    self.totalTime += ellapsedTime;
    
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:self.totalTime];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"ss "];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString = [dateFormatter stringFromDate:timeDate];
    self.mainStopwatchLabel.text = timeString;
    
    
    NSLog(@"%f", self.totalTime);
}

- (void) updateStopwatchTimer {
    NSDate *currentdate = [NSDate date];
    NSTimeInterval timerInterval = [currentdate timeIntervalSinceDate:self.start];
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:timerInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"mm : ss : SS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString = [dateFormatter stringFromDate:timeDate];
    self.stopwatchTimerLabel.text = timeString;
}


- (IBAction)stopStopwatchButton:(UIButton *)sender {
    
    [self.mainStopwatch invalidate];
    [self.stopwatch invalidate];
    self.mainStopwatch = nil;
    self.stopwatch = nil;
}

- (IBAction)lapStopwatchButton:(UIButton *)sender {
    
    self.start = [[NSDate alloc]init];
    
    [self.laps addObject:self.stopwatchTimerLabel.text];
    
    [self.tableView reloadData];
    
    
    NSIndexPath* ipath = [NSIndexPath indexPathForRow:[self.laps count]-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
    
    self.lapNumber = ipath.row + 1;
    
    [self.numberOfLaps addObject: [NSNumber numberWithInteger:self.lapNumber]];
}


// UI TABLE VIEW

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.laps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimeLap" forIndexPath:indexPath];
    
   if (!cell) {
   cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TimeLap"];
    }
   
    NSString *key = [self.laps objectAtIndex:indexPath.row];
    NSString *lap = [self.numberOfLaps objectAtIndex:indexPath.row];

    cell.detailTextLabel.text = key;
    cell.textLabel.text = [NSString stringWithFormat:@"Lap %@",lap];
    
    return cell;
}


@end
