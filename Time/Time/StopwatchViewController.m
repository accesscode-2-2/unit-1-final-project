//
//  StopwatchViewController.m
//  Time
//
//  Created by Chris David on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopwatchViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface StopwatchViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;



@end

@implementation StopwatchViewController
@synthesize stopwatchLabel;
@synthesize lapLabel;
@synthesize lapTableView;


- (void)viewDidLoad {
    [super viewDidLoad];
    stopwatchLabel.text = @"00.00.00";
    lapLabel.text =@"00.00.00";
    running = FALSE;
    startDate = [NSDate date];
    restartDate =[NSDate date];
    self.startButton.layer.cornerRadius = 37.5;
    self.startButton.clipsToBounds = YES;
    self.resetButton.layer.cornerRadius = 37.5;
    self.resetButton.clipsToBounds = YES;
    self.lapTableView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.lapTableView.layer.borderWidth = 2.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)startButton:(id)sender {
    
    if(!running){
       running = TRUE;
        [sender setTitle:@"Pause" forState:UIControlStateNormal];
        [self.resetButton setTitle:@"Log" forState:UIControlStateNormal];
        
        if (stopTimer == nil) {
            stopTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                         target:self
                                                       selector:@selector(updateTimer)
                                                       userInfo:nil
                                                        repeats:YES];
            lapTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                         target:self
                                                       selector:@selector(lapTimer)
                                                       userInfo:nil
                                                        repeats:YES];
        }
    }else{
        running = FALSE;
        [sender setTitle:@"Start" forState:UIControlStateNormal];
         [self.resetButton setTitle:@"Reset" forState:UIControlStateNormal];
        [stopTimer invalidate];
        stopTimer = nil;
        [lapTimer invalidate];
        lapTimer = nil;
        
    }

}

-(void)updateTimer{
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDate];
    
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss.SS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
    stopwatchLabel.text = timeString;
}

- (void)lapTimer {
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:restartDate];
    
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss.SS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
    lapLabel.text = timeString;
}

- (IBAction)resetButton:(id)sender {
    
    if (running ) {
        [lapTimer invalidate];
        lapTimer = nil;
        restartDate = [NSDate date];
        [self lapTimer];
        lapTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                    target:self
                                                  selector:@selector(lapTimer)
                                                  userInfo:nil
                                                   repeats:YES];
        
    }else{
    
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    [stopTimer invalidate];
    stopTimer = nil;
    [lapTimer invalidate];
    lapTimer = nil;
    startDate = [NSDate date];
    stopwatchLabel.text = @"00.00.00";
    lapLabel.text = @"00.00.00";
    
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LapLabelCellIdentifier" forIndexPath:indexPath];
    self.lapLabel.text = cell.textLabel.text; 
    cell.textLabel.text =
    [NSString stringWithFormat:@"Row: %li", (long)indexPath.row];
    
    return cell;
}



@end
