//
//  StopwatchViewController.m
//  Time
//
//  Created by Mesfin Bekele Mekonnen on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopwatchViewController.h"
#import "LapTableViewController.h"
//@import QuartzCore;

@interface StopwatchViewController ()
@property (weak, nonatomic) IBOutlet UIView *timerView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *lapButton;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *lapLabel;
@property (nonatomic) CFTimeInterval initialTime;
@property (nonatomic) CFTimeInterval lapInitialTime;
@property (nonatomic) CADisplayLink *stopwatchTimer;
@property (nonatomic) NSMutableArray *lapTimes;
@property (weak, nonatomic) IBOutlet UITableView *lapTableView;

@property (nonatomic) LapTableViewController *ltvc;
@property (nonatomic) NSString *currentLapTime;

@end

@implementation StopwatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIView setAnimationsEnabled:NO];
    
    self.lapTimes = [NSMutableArray new];
    self.stopwatchTimer  = [CADisplayLink displayLinkWithTarget:self
                                                       selector:@selector(refreshTimerLabel)];
    [self.stopwatchTimer setPaused:YES];
    [self.stopwatchTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [self embedTableView];
    
    self.lapTableView.dataSource = self.ltvc;
    self.lapTableView.delegate = self.ltvc;
    
    

   // self.lapTableView.delegate = self;
    

    
    //self.lapTableView.backgroundColor = [UIColor blackColor];
    
//    for (NSString* family in [UIFont familyNames]) {
//        NSLog(@"%@", family);
//        for (NSString* name in [UIFont fontNamesForFamilyName: family]) {
//            NSLog(@"  %@", name);
//        }
//    }
}

- (void)embedTableView {
    
    self.ltvc = [[LapTableViewController alloc]init];
    [self addChildViewController:self.ltvc];
    
    self.ltvc.view.frame = self.lapTableView.bounds;//  _view.bounds;
    [self.lapTableView addSubview:self.ltvc.view];
    
    [self.ltvc willMoveToParentViewController:self];
}


- (NSString *)formatTimeString:(CFTimeInterval)timeInterval{
    CFTimeInterval currentTime = CACurrentMediaTime();
    CFTimeInterval difference = currentTime - timeInterval;
    
    NSString *string = [NSString stringWithFormat:@"%02li:%02li.%03li",
                        // lround(floor(difference / 3600.)) % 100,
                        lround(floor(difference / 60.)) % 60,
                        lround(floor(difference)) % 60,
                        lround(floor(difference * 1000)) % 1000];
    return string;
}

- (void)refreshTimerLabel{
    self.timerLabel.text = [self formatTimeString:self.initialTime];
    self.lapLabel.text = [self formatTimeString:self.lapInitialTime];
}

- (IBAction)startButtonTapped:(UIButton *)sender {
    if ([self.startButton.titleLabel.text isEqualToString:@"Start"]) {
        [self.stopwatchTimer setPaused:NO];
        if([self.timerLabel.text isEqualToString:@"00:00.000"]){
            self.initialTime = CACurrentMediaTime();
            self.lapInitialTime = self.initialTime;
        }
        [self.startButton setTitle:@"Pause" forState:UIControlStateNormal];
        [self.lapButton setTitle:@"Lap" forState:UIControlStateNormal];
    } else {
        [self.stopwatchTimer setPaused:YES];
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        [self.lapButton setTitle:@"Reset" forState:UIControlStateNormal];
    }
    
}

- (IBAction)lapButtonTapped:(UIButton *)sender {
    if([self.lapButton.titleLabel.text isEqualToString:@"Lap"]){
        self.lapInitialTime = CACurrentMediaTime();
        
        [self.lapTimes addObject:self.lapLabel.text];
        NSLog(@"%@",self.lapTimes);
        self.currentLapTime = self.lapLabel.text;
        NSLog(@"%@",self.currentLapTime);
        [self.delegate currentLapTime:self.currentLapTime];
        NSLog(@"%@ HI I am delegate",[self.ltvc currentLapTime:self.currentLapTime]);
        [self.lapTableView reloadData];
        //NSLog(@"%@", self.lapTimes);
    } else {
        [self.lapTimes removeAllObjects];
        [self.lapTableView reloadData];
        self.lapLabel.text = @"00:00.000";
        self.timerLabel.text = @"00:00.000";
    }
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.lapTimes count];
//}
//
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
////    cell.backgroundColor = [UIColor blackColor];
////    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.textLabel.font = [UIFont fontWithName:@"Orbitron-Regular" size:15];
//    cell.detailTextLabel.font = [UIFont fontWithName:@"DigitalReadoutExpUpright" size:19];
//    cell.detailTextLabel.textColor = [UIColor blackColor];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lapIdentifier" forIndexPath:indexPath];
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"Lap %ld",[self.lapTimes count] - indexPath.row];
//    cell.detailTextLabel.text = self.lapTimes[[self.lapTimes count] - 1 - indexPath.row];
//    return cell;
//}

@end
