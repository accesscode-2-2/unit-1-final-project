//
//  EventsCountdownViewController.m
//  TimerStopwatch
//
//  Created by Charles Kang  on 8/27/15.
//  Copyright (c) 2015 Charles Kang . All rights reserved.
//

#import "EventsCountdownViewController.h"
#import "TimerViewController.h"

@interface EventsCountdownViewController ()

@property (strong, nonatomic) IBOutlet UIDatePicker *timeTillBirthday;
@property (strong, nonatomic) IBOutlet UILabel *countdownLabel;


- (IBAction)startCountdown:(id)sender;

@end

@implementation EventsCountdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)startCountdown:(id)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *birthday = [formatter dateFromString:@"2016-02-21"];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger preservedComponents = (NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitDay);
    self.timeTillBirthday.date = birthday;
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

-(void)updateTime
{
    NSInteger time = ((NSInteger)[self.timeTillBirthday.date timeIntervalSinceNow]);
    NSInteger seconds = time % 60;
    NSInteger minutes = (time / 60) % 60;
    NSInteger hours = (time / 3600) % 24;
    NSInteger days = (time / 86400);
    
    NSString *timeDisplay = [[NSString alloc] initWithFormat:@"%02u : %02u : %02u", days, hours, minutes, seconds];
    
    self.countdownLabel.text = [NSString stringWithFormat:@"%0.2ld", (long)time];
    NSLog(@"%ld", (long)time);
    self.countdownLabel.text = timeDisplay;
}

@end
