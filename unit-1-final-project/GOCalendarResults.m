//
//  GOCalendarResults.m
//  unit-1-final-project
//
//  Created by Fatima Zenine Villanueva on 8/25/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "GOCalendarResults.h"

@interface GOCalendarResults ()
@property (weak, nonatomic) IBOutlet UILabel *countdownResultsLabel;
@property (nonatomic) NSDateFormatter *formatter;
@property (nonatomic) NSDate *date;

@end

@implementation GOCalendarResults

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.date = self.scheduledDate; //save in a property, this will be your start date
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(refreshLabel)
                                   userInfo:nil
                                    repeats:YES];
}



-(void)refreshLabel
{
    NSDate *dateCountDown = [NSDate dateWithTimeIntervalSince1970:[self.date timeIntervalSince1970] - 1]; //the start-up date minus 1 sec.
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatterCurrent = [[NSDateFormatter alloc]init];
    [formatterCurrent setDateFormat:@"D"];
    NSDateFormatter *DayFormatter = [[NSDateFormatter alloc]init];
    [DayFormatter setDateFormat:@"D"];
    [DayFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSDateFormatter *HourFormatter = [[NSDateFormatter alloc]init];
    [HourFormatter setDateFormat:@"HH"];
    [HourFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSDateFormatter *MinuteFormatter = [[NSDateFormatter alloc]init];
    [MinuteFormatter setDateFormat:@"mm"];
    [MinuteFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSDateFormatter *SecondFormatter = [[NSDateFormatter alloc]init];
    [SecondFormatter setDateFormat:@"ss"];
    [SecondFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    //self.countdownResultsLabel.text = [timeFormatter stringFromDate:dateCountDown];

    

    NSInteger difference = [self daysBetween:currentDate and:self.date];
    NSString *daysLeftString = @(difference).stringValue;
    
    
    NSString *formattedDateString = [dateFormatter stringFromDate:self.date];
    NSString *formattedHour = [HourFormatter stringFromDate:self.date];
    NSString *formattedMinute = [MinuteFormatter stringFromDate:self.date];
    NSString *formattedSeconds = [SecondFormatter stringFromDate:self.date];
    
    NSString *newLabel = [NSString stringWithFormat:@"Goal Date %@ \n \n Time Left: \n \n Days: %@\n Hours %@\n Minutes %@\n Seconds%@", formattedDateString,daysLeftString, formattedHour, formattedMinute, formattedSeconds];
    self.countdownResultsLabel.text = newLabel;
    // Output for locale en_US: "formattedDateString: Jan 2, 2001".
    self.date = dateCountDown;
    

}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
