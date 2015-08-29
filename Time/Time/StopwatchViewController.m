//
//  StopwatchViewController.m
//  Time
//
//  Created by Chris David on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopwatchViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface StopwatchViewController ()
- (void)configureView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;





@end

@implementation StopwatchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.stopwatchLabel.text = @"00.00.00";
    self.lapLabel.text =@"00.00.00";
    self.running = FALSE;
    self.startDate = [NSDate date];
    self.restartDate =[NSDate date];
    self.startButton.layer.cornerRadius = 37.5;
    self.startButton.clipsToBounds = YES;
    self.resetButton.layer.cornerRadius = 37.5;
    self.resetButton.clipsToBounds = YES;
    self.lapTableView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.lapTableView.layer.borderWidth = 1.0;
    [self configureView];
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:205 green:255 blue:255 alpha:1]];
    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    

}
- (void)configureView
{
    self.dataArray = [[NSMutableArray alloc] init];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)startButton:(id)sender {
    
    if(!self.running){
       self.running = TRUE;
        [sender setTitle:@"Pause" forState:UIControlStateNormal];
        [self.resetButton setTitle:@"Lap" forState:UIControlStateNormal];
        
        if (self.stopTimer == nil && self.lapTimer == nil) {
            self.stopTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                         target:self
                                                       selector:@selector(updateTimer)
                                                       userInfo:nil
                                                        repeats:YES];
            self.lapTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                         target:self
                                                       selector:@selector(rememberTimer)
                                                       userInfo:nil
                                                        repeats:YES];
           
            
        }
    }else{
        self.running = FALSE;
        [sender setTitle:@"Start" forState:UIControlStateNormal];
         [self.resetButton setTitle:@"Reset" forState:UIControlStateNormal];
        [self.stopTimer invalidate];
        self.stopTimer = nil;
        [self.lapTimer invalidate];
        self.lapTimer = nil;
        
    }

}

-(void)updateTimer{
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
    
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss.SS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
    self.stopwatchLabel.text = timeString;
}

-(void)rememberTimer{
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.restartDate];
    
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss.SS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
    self.lapLabel.text = timeString;
}

- (IBAction)resetButton:(id)sender {
    [self.lapTableView reloadData];
    if (self.running ) {
        [self.dataArray addObject:self.lapLabel.text];
        [self.lapTableView reloadData];
        [self.lapTimer invalidate];
        self.lapTimer = nil;
        self.restartDate = [NSDate date];
        [self lapTimer];
        self.lapTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                    target:self
                                                  selector:@selector(rememberTimer)
                                                  userInfo:nil
                                                   repeats:YES];
      
 
    }else{
        
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        [self.stopTimer invalidate];
        self.stopTimer = nil;
        [self.lapTimer invalidate];
        self.lapTimer = nil;
        self.restartDate = [NSDate date];
        self.startDate = [NSDate date];
        self.stopwatchLabel.text = @"00.00.00";
        self.lapLabel.text = @"00.00.00";
        [self.dataArray removeAllObjects];
        [self.lapTableView reloadData];
        
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *labelID = @"LapLabelCellIdentifier";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:labelID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:labelID];
    }
    cell.detailTextLabel.text = [self.dataArray objectAtIndex: [self.dataArray count] - indexPath.row - 1];
    
    NSString *rowCounter = [NSString stringWithFormat:@"Lap %ld",[self.dataArray count] -(long)indexPath.row];
    cell.textLabel.text = rowCounter;
    
    return cell;
}






@end
