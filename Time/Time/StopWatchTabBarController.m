//
//  StopWatchTabBarController.m
//  Time
//
//  Created by Xiulan Shi on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopWatchTabBarController.h"

//@interface StopWatchTabBarController () <UITableViewDelegate, UITableViewDataSource>
@interface StopWatchTabBarController () <UITableViewDataSource, UITabBarDelegate>

@property (strong, nonatomic) IBOutlet UILabel *timerDisplay;
@property (strong, nonatomic) IBOutlet UILabel *lapTimerLabel;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *lapButton;
@property (weak, nonatomic) IBOutlet UITableView *lapsTableView;
@property (nonatomic) BOOL timerIsRunning;
@property (nonatomic) NSMutableArray *savedLapTimes;

@end

@implementation StopWatchTabBarController

float timeTick = 0.00; // the timer always begins at this number!
NSTimer *timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timerIsRunning = NO;
    self.timerDisplay.text = [[NSString alloc] initWithFormat:@"%.2f",timeTick];
    self.lapTimerLabel.text = [[NSString alloc] initWithFormat:@"%.2f", timeTick];
    
    [self.startButton setTitle:@"START" forState:UIControlStateNormal]; // set default text
    [self.lapButton setTitle:@"LAP" forState:UIControlStateNormal];
    
    // self.savedLapTimes = [NSMutableArray arrayWithObjects:@"", nil]; // store lap times
    self.savedLapTimes = [NSMutableArray new];
    
   
   

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tick {
    
    float currentNumber = [self.timerDisplay.text floatValue]; // get float value of string each time timer is fired
    float currentLap = [self.lapTimerLabel.text floatValue];
    
    float nextNumber = currentNumber +.01; // add 0.01 to present time
    float nextLap = currentLap +.01;
    
    self.timerDisplay.text = [NSString stringWithFormat:@"%.2f", nextNumber]; // set time to label text
    self.lapTimerLabel.text = [NSString stringWithFormat:@"%.2f", nextLap];
   }

- (IBAction)startPauseButton:(id)sender { // start button tapped
    
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    if (self.timerIsRunning) {
        
        self.timerIsRunning = NO; // timer state: stopped
        [timer invalidate];
        [self.startButton setTitle:@"START" forState:UIControlStateNormal];
        [self.lapButton setTitle:@"RESET" forState:UIControlStateNormal];
        
    } else {
        
        self.timerIsRunning = YES; // timer state: running
        [self.startButton setTitle:@"PAUSE" forState:UIControlStateNormal];
        [self.lapButton setTitle:@"LAP" forState:UIControlStateNormal];
    }
}

- (IBAction)lapButton:(id)sender { // lap button tapped
    
    if (self.timerIsRunning) { // timer state: running
        
        [self.savedLapTimes insertObject:self.lapTimerLabel.text atIndex:0]; // add new item to the top of the list
       
        
        NSLog(@"savedLapTimes = %@", self.lapTimerLabel.text); // log text to test
        NSLog(@"%@", self.savedLapTimes);
        
        [self.lapsTableView reloadData]; // reload view with new values added
        
        self.lapTimerLabel.text = @"0.00";
        
    } else {
        
        self.timerDisplay.text = @"0.00"; // main label keep going
        self.lapTimerLabel.text = @"0.00"; // lap label set to 0 (should also record time!!)

        [self.savedLapTimes removeAllObjects]; // reset lap array
        [self.lapsTableView reloadData]; // reload table view

    }
}


// Set up tableView here:
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.savedLapTimes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"savedLapTimeIdentifier" forIndexPath:indexPath];
    
//    cell.textLabel.text = self.savedLapTimes[indexPath.row];
    
 //this should add lap numbers to code...
    NSInteger index = self.savedLapTimes.count - indexPath.row;
    NSString *cellText = [NSString stringWithFormat: @"Lap %ld \t \t", (long)index];
    cell.textLabel.text = cellText;
    cell.detailTextLabel.text = self.savedLapTimes[indexPath.row]; // set detail text label to time
    
    return cell;

}

@end
