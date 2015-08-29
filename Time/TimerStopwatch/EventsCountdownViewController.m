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

- (IBAction)startCountdown:(id)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyy-MM-dd"];
    NSDate *birthday = [formatter dateFromString:@"2016-02-21"];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterLongStyle];
    
    [self.timeTillBirthday setDate:birthday animated:NO];
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger preservedComponents = (NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitDay);
    self.timeTillBirthday.date = birthday; //[calendar dateFromComponents:[calendar components:preservedComponents fromDate:self.timeTillBirthday.date]];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

-(void)updateTime
{
    NSInteger time = ((NSInteger)[self.timeTillBirthday.date timeIntervalSinceNow]);
    NSInteger seconds = time % 60;
    NSInteger minutes = (time / 60) % 60;
    NSInteger hours = (time / 3600) % 24;
    NSInteger days = (time / 86400);
    
    NSLog(@"%ld", (long)time);
    NSLog(@"%ld, %ld, %ld, %ld", days, hours, minutes, seconds);
    NSString *timeDisplay = [[NSString alloc] initWithFormat:@" %02ldd  : %02ldh : %02ldm : %02lds", (long)days, (long)hours, (long)minutes, (long)
                             seconds];
    
    self.countdownLabel.text = timeDisplay;
}

@end
