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

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UILabel *birthdayCountdownLabel;
@property (strong, nonatomic) IBOutlet UILabel *christmasCountdownLabel;

@property (nonatomic) NSDate *birthday;
@property (nonatomic) NSDate *christmas;


- (IBAction)startCountdown:(id)sender;

@end

@implementation EventsCountdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)startBirthdayCountdown:(id)sender {
    
    NSDateFormatter *birthdayFormatter = [[NSDateFormatter alloc] init];
    [birthdayFormatter setDateFormat:@"yyy-MM-dd"];
    self.birthday = [birthdayFormatter dateFromString:@"2016-02-21"];
    [birthdayFormatter setDateStyle:NSDateFormatterLongStyle];
    [birthdayFormatter setTimeStyle:NSDateFormatterLongStyle];
    
    [self.datePicker setDate:self.birthday animated:NO];
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger preservedComponents = (NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitDay);
    self.datePicker.date = self.birthday;
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateBirthdayTime) userInfo:nil repeats:YES];
}

- (IBAction)startChristmasCountdown:(id)sender {
    NSDateFormatter *christmasFormatter = [[NSDateFormatter alloc] init];
    [christmasFormatter setDateFormat:@"yyy-MM-dd"];
    self.christmas = [christmasFormatter dateFromString:@"2015-12-25"];
    [christmasFormatter setDateStyle:NSDateFormatterLongStyle];
    [christmasFormatter setTimeStyle:NSDateFormatterLongStyle];
    
    [self.datePicker setDate:self.christmas animated:NO];
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger preservedComponents = (NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitDay);
    self.datePicker.date = self.christmas;
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateChristmasTime) userInfo:nil repeats:YES];
}

-(void)updateBirthdayTime

{
    NSInteger time = ((NSInteger)[self.birthday timeIntervalSinceNow]);
    NSInteger seconds = time % 60;
    NSInteger minutes = (time / 60) % 60;
    NSInteger hours = (time / 3600) % 24;
    NSInteger days = (time / 86400);
    
    NSLog(@"%ld", (long)time);
    NSLog(@"%ld, %ld, %ld, %ld", days, hours, minutes, seconds);
    NSString *timeDisplay = [[NSString alloc] initWithFormat:@" %02ldd  : %02ldh : %02ldm : %02lds", (long)days, (long)hours, (long)minutes, (long) seconds];
    
    self.birthdayCountdownLabel.text = timeDisplay;
}

-(void)updateChristmasTime

{
    NSInteger time = ((NSInteger)[self.christmas timeIntervalSinceNow]);
    NSInteger seconds = time % 60;
    NSInteger minutes = (time / 60) % 60;
    NSInteger hours = (time / 3600) % 24;
    NSInteger days = (time / 86400);
    
    NSLog(@"%ld", (long)time);
    NSLog(@"%ld, %ld, %ld, %ld", days, hours, minutes, seconds);
    NSString *timeDisplay = [[NSString alloc] initWithFormat:@" %02ldd  : %02ldh : %02ldm : %02lds", (long)days, (long)hours, (long)minutes, (long) seconds];
    
    self.christmasCountdownLabel.text = timeDisplay;
}


@end
