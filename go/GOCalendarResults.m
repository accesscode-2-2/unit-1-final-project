//
//  GOCalendarResults.m
//  unit-1-final-project
//
//  Created by Fatima Zenine Villanueva on 8/25/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "BackgroundGradient.h"
#import "GOCalendarResults.h"

@interface GOCalendarResults ()
@property (weak, nonatomic) IBOutlet UILabel *countdownResultsLabel;
@property (nonatomic) NSDateFormatter *formatter;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSDate *date;

@end

@implementation GOCalendarResults

-(void)viewWillAppear:(BOOL)animated{
    
    CAGradientLayer *bgLayer = [BackgroundGradient greenGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
    self.date = self.scheduledDate; // save in property -- this is the start date
    
    // the timer that counts down the scheduled date
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(refreshLabel)
                                   userInfo:nil
                                    repeats:YES];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)buttonTapped:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)refreshLabel
{
    //the start-up date minus 1 sec.
    NSDate *dateCountDown = [NSDate dateWithTimeIntervalSince1970:[self.date timeIntervalSince1970] - 1];
    
    // the current date at the moment
    NSDate *currentDate = [NSDate date];
    
    // the goal date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    // the hour formatter
    NSDateFormatter *HourFormatter = [[NSDateFormatter alloc]init];
    [HourFormatter setDateFormat:@"HH"];
    [HourFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // the minute formatter
    NSDateFormatter *MinuteFormatter = [[NSDateFormatter alloc]init];
    [MinuteFormatter setDateFormat:@"mm"];
    [MinuteFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // the seconds formatter
    NSDateFormatter *SecondFormatter = [[NSDateFormatter alloc]init];
    [SecondFormatter setDateFormat:@"ss"];
    [SecondFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // calls the difference method and stores it in a string
    NSInteger difference = [self daysBetween:currentDate and:self.date];
    NSString *daysLeftString = @(difference).stringValue;
    
    // converts the formatter into strings
    NSString *formattedDateString = [dateFormatter stringFromDate:self.date];
    NSString *formattedHour = [HourFormatter stringFromDate:self.date];
    NSString *formattedMinute = [MinuteFormatter stringFromDate:self.date];
    NSString *formattedSeconds = [SecondFormatter stringFromDate:self.date];
    
    // stores all the strings in one string for the output label
    NSString *newLabel = [NSString stringWithFormat:@"%@ \n \n Time Left \n \n Days :  %@\n Hours : %@\n Minutes : %@\n Seconds : %@", formattedDateString,daysLeftString, formattedHour, formattedMinute, formattedSeconds];
    
    // stores the countdown label into the new string
    self.countdownResultsLabel.text = newLabel;
    
    // updates the output
    self.date = dateCountDown;
}

// This is the method that subtracts the date from now versus the goal date
- (NSInteger)daysBetween:(NSDate *)dt1 and:(NSDate *)dt2 {
    NSInteger unitFlags = NSDayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:dt1 toDate:dt2 options:0];
    return [components day]+1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.timer invalidate];
}

@end
