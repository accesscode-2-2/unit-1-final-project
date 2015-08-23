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
@synthesize stopwatchLabel;
@synthesize lapLabel;
@synthesize lapTableView;
@synthesize dataArray;



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
    [self configureView];
    

}
- (void)configureView
{
    self.dataArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)startButton:(id)sender {
    
    if(!running){
       running = TRUE;
        [sender setTitle:@"Pause" forState:UIControlStateNormal];
        [self.resetButton setTitle:@"Lap" forState:UIControlStateNormal];
        
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
    [self.lapTableView reloadData];
    if (running ) {
        [self.dataArray addObject:self.lapLabel.text];
        [self.lapTableView reloadData];
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
    cell.detailTextLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    
    NSString *rowCounter = [NSString stringWithFormat:@"Lap %ld", (long)indexPath.row];
    cell.textLabel.text = rowCounter;
    
    return cell;
}





@end
