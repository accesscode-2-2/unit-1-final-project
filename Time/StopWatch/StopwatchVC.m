//
//  StopwatchVC.m
//  StopWatch
//
//  Created by Natalia Estrella on 8/23/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import "StopwatchVC.h"

@interface StopwatchVC ()
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;
@property (weak, nonatomic) IBOutlet UIButton *lapResetButton;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic) NSMutableArray *laps; 



@end

@implementation StopwatchVC


- (IBAction)startStopTapped:(id)sender {
    
//    if ([self.startStopButton.titleLabel.text isEqualToString:@"Start"]) {
//        [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
//    }
//    else {
//        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
//    }
    
    if ([self.startStopButton.titleLabel.text isEqualToString:@"Start"]) {
        
        //set self.startTimer to NOW
        self.startTime = [[NSDate alloc] init];
        
        //set up timer
        self.timer = [NSTimer timerWithTimeInterval:1/60.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        
        //timer to the run loop
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

        
        [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
        
        [self.lapResetButton setTitle:@"Lap" forState:UIControlStateNormal];

    }
    else {
        //        //This is where you died
        self.totalTime = self.totalTime + self.totalSessionTime;
        [self.timer invalidate];
        
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        [self.lapResetButton setTitle:@"Reset" forState:UIControlStateNormal];
        
    }
    
}
//- (IBAction)lapResetTapped:(id)sender {
//    if ([self.lapResetButton.titleLabel.text isEqualToString:@"Lap"]) {
//        [self.laps insertObject:self.laps atIndex:index 0];
//        [self.laps inser]
//    }
//    
//    else {
//        [self.lapResetButton.titleLabel.text isEqualToString:@"Reset"];
//        
//        [self.laps removeAllObjects];
//        
//    }
//}

- (void)timerFired:(NSTimer *)timer {
 
    //get the current time
    NSDate *now = [[NSDate alloc] init];
    
    self.totalSessionTime = [now timeIntervalSinceDate:self.startTime];
    NSTimeInterval distance = self.totalTime + self.totalSessionTime;
    
    self.timerLabel.text = [NSString stringWithFormat:@"%0.2f", distance];
    NSLog(@"%f", distance);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.timerLabel.text = [NSString stringWithFormat:@"0.0"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.laps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    //you only have one section
    
    cell.textLabel.text = [NSString stringWithFormat:@"Laps %@", self.laps [indexPath.row]];
    cell.detailTextLabel.text = self.laps[indexPath.row];
    
    
    
    // Configure the cell...
    
    return cell;
}



@end
