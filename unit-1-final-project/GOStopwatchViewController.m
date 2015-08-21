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

@end

@implementation GOStopwatchViewController

- (void)viewDidLoad {
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    self.model = [[LapTimerTableViewCell alloc] init];
    
    [super viewDidLoad];
    
    self.laps = [[NSMutableArray alloc]init];
    
    self.start = [[NSDate alloc]init];
    
    self.mainDate = [[NSDate alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


// Press start to begin timer
- (IBAction)startStopwatchButton:(UIButton *)sender {
    
    
    
    self.stopwatch = [NSTimer scheduledTimerWithTimeInterval:1.0/100.0
                                                      target:self
                                                    selector:@selector(updateStopwatchTimer)
                                                    userInfo:nil repeats:YES];
    
    self.mainStopwatch = [NSTimer scheduledTimerWithTimeInterval:1.0/100.0
                                                          target:self
                                                        selector:@selector(updateMainStopwatchTimer)
                                                        userInfo:nil repeats:YES];
}

-(void) updateMainStopwatchTimer {
    NSDate *currentdate = [NSDate date];
    NSTimeInterval timerInterval = [currentdate timeIntervalSinceDate:self.mainDate];
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:timerInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"mm : ss : SS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString = [dateFormatter stringFromDate:timeDate];
    self.mainStopwatchLabel.text = timeString;
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
    self.pauseTime = [self.mainDate timeIntervalSinceNow];
    
    self.mainDate = [NSDate dateWithTimeIntervalSinceNow:self.pauseTime];
    
    NSLog(@"%f", self.pauseTime);
    
    [self.mainStopwatch invalidate];
    [self.stopwatch invalidate];
}

- (IBAction)lapStopwatchButton:(UIButton *)sender {
    
    self.start = [[NSDate alloc]init];
    
    [self.laps addObject:self.stopwatchTimerLabel.text];
    NSLog(@"%@", self.laps);
    
    [self.tableView reloadData];
    
    
    NSIndexPath* ipath = [NSIndexPath indexPathForRow:[self.laps count]-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
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

    cell.textLabel.text = key;
    
    return cell;
}


@end
