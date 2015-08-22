//
//  StopWatchTabBarController.m
//  Time
//
//  Created by Xiulan Shi on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopWatchTabBarController.h"

@interface StopWatchTabBarController ()


@end

@implementation StopWatchTabBarController

float timeTick = 0.00; // the timer always begins at this number
NSTimer *timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timerDisplay.text = [[NSString alloc] initWithFormat:@"%.2f",timeTick];
    [self.startButton setTitle:@"START" forState:UIControlStateNormal];
    [self.lapButton setTitle:@"RESET" forState:UIControlStateNormal];
}

- (void)tick { // the timer loop will run this method each time it is initiated, it advances the number
    
    float currentNumber = [self.timerDisplay.text floatValue]; // get float value of string each time timer is fired
    float nextNumber = currentNumber +.01; // add 0.01 to present time
    
    // convert and then display as hours:minutes:seconds
    
    self.timerDisplay.text = [NSString stringWithFormat:@"%.2f", nextNumber]; // set time to label text
   }

- (IBAction)startPauseButton:(id)sender {
    
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    if (self.timerIsRunning) {
        self.timerIsRunning = NO;
        [timer invalidate];
        [self.startButton setTitle:@"START" forState:UIControlStateNormal];
        [self.lapButton setTitle:@"RESET" forState:UIControlStateNormal];
    } else {
        self.timerIsRunning = YES;
        [self.startButton setTitle:@"PAUSE" forState:UIControlStateNormal];
        [self.lapButton setTitle:@"LAP" forState:UIControlStateNormal];
    }
}

- (IBAction)lapButton:(id)sender {
    if (self.timerIsRunning) {
        self.timerIsRunning = NO;
        NSLog(@"HELLO1");
        
    } else {
        self.timerIsRunning = YES; // reset paused timer to 0
        self.timerDisplay.text = @"0.00";
        NSLog(@"HELLO2");


    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}


@end
