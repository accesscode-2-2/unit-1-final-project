//
//  StopwatchViewController.m
//  Time
//
//  Created by Mesfin Bekele Mekonnen on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopwatchViewController.h"
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

@end

@implementation StopwatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lapTimes = [NSMutableArray new];
    self.stopwatchTimer  = [CADisplayLink displayLinkWithTarget:self
                                                       selector:@selector(refreshTimerLabel)];
    [self.stopwatchTimer setPaused:YES];
    [self.stopwatchTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    self.lapTableView.dataSource = self;
    self.lapTableView.delegate = self;
    //self.lapTableView.backgroundColor = [UIColor blackColor];
    
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
    
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

-(void)refreshTimerLabel{
   
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
        [self.lapTableView reloadData];
        NSLog(@"%@", self.lapTimes);
    } else {
        [self.lapTimes removeAllObjects];
        [self.lapTableView reloadData];
        self.lapLabel.text = @"00:00.000";
        self.timerLabel.text = @"00:00.000";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.lapTimes count];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    cell.backgroundColor = [UIColor blackColor];
//    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Orbitron-Regular" size:15];
    cell.detailTextLabel.font = [UIFont fontWithName:@"DigitalReadoutExpUpright" size:19];
    cell.detailTextLabel.textColor = [UIColor blackColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lapIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Lap %ld",[self.lapTimes count] - indexPath.row];
    cell.detailTextLabel.text = self.lapTimes[[self.lapTimes count] - 1 - indexPath.row];
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
