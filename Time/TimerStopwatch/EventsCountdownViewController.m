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
@property (strong, nonatomic) IBOutlet UILabel *accessCodeCountdownLabel;

@property (nonatomic) NSDate *birthday;
@property (nonatomic) NSDate *christmas;
@property (nonatomic) NSDate *accessCode;

@end

@implementation EventsCountdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.birthdayStartButton.layer.borderWidth = 2.0;
    self.birthdayStartButton.layer.cornerRadius = 11.0;
    self.birthdayStartButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.birthdayStartButton setClipsToBounds:YES];
    
    self.christmasStartButton.layer.borderWidth = 2.0;
    self.christmasStartButton.layer.cornerRadius = 11.0;
    self.christmasStartButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.christmasStartButton setClipsToBounds:YES];
    
    self.ACStartButton.layer.borderWidth = 2.0;
    self.ACStartButton.layer.cornerRadius = 11.0;
    self.ACStartButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.ACStartButton setClipsToBounds:YES];
    
    
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

- (IBAction)startACCountdown:(id)sender {
    
    NSDateFormatter *accessCodeFormatter = [[NSDateFormatter alloc] init];
    [accessCodeFormatter setDateFormat:@"yyy-MM-dd"];
    self.accessCode = [accessCodeFormatter dateFromString:@"2016-02-28"];
    [accessCodeFormatter setDateStyle:NSDateFormatterLongStyle];
    [accessCodeFormatter setTimeStyle:NSDateFormatterLongStyle];
    
    [self.datePicker setDate:self.accessCode animated:NO];
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger preservedComponents = (NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitDay);
    self.datePicker.date = self.accessCode;
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateAccessCodeTime) userInfo:nil repeats:YES];
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

-(void)updateAccessCodeTime

{
    NSInteger time = ((NSInteger)[self.accessCode timeIntervalSinceNow]);
    NSInteger seconds = time % 60;
    NSInteger minutes = (time / 60) % 60;
    NSInteger hours = (time / 3600) % 24;
    NSInteger days = (time / 86400);
    
    NSLog(@"%ld", (long)time);
    NSLog(@"%ld, %ld, %ld, %ld", days, hours, minutes, seconds);
    NSString *timeDisplay = [[NSString alloc] initWithFormat:@" %02ldd  : %02ldh : %02ldm : %02lds", (long)days, (long)hours, (long)minutes, (long) seconds];
    
    self.accessCodeCountdownLabel.text = timeDisplay;
}

@end
