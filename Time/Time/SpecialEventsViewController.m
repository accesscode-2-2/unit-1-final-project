//
//  SpecialEventsViewController.m
//  Time
//
//  Created by Eric Sze on 9/3/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "SpecialEventsViewController.h"

@interface SpecialEventsViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *leftCircle;

@property (weak, nonatomic) IBOutlet UIDatePicker *pickerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic) NSDateComponents *comps;
@property (nonatomic) NSDate *now;
@property (nonatomic) NSDate *targetDate;
@property (nonatomic) NSTimer *countDownTimer;
@property (nonatomic) NSMutableArray *event;

@property (nonatomic) NSInteger totalSecondsLeft;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation SpecialEventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftCircle.layer.cornerRadius = 34.5;
    self.leftCircle.layer.masksToBounds = YES;
    
    UIImage *backgroundImage = [UIImage imageNamed:@"track"];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
    self.scrollView.contentSize = backgroundImage.size;
    [self.scrollView addSubview:backgroundImageView];
    
    self.timerLabel.text = @"";
    [self.dateLabel setHidden:YES];

}

- (IBAction)createButton:(UIButton *)sender {
//
    
    //Remove the time component from the datePicker.  We care only about the date
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger preservedComponents = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
    self.pickerView.date = [calendar dateFromComponents:[calendar components:preservedComponents fromDate:self.pickerView.date]];
    //self.dateLabel.text = self.pickerView.date;
    //Set up a timer that calls the updateTime method every second to update the label
    NSTimer *timer;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(updateTime)
                                           userInfo:nil
                                            repeats:YES];
//    NSDate *rightNow = [NSDate date];
//    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *newDateString = [outputFormatter stringFromDate:rightNow];
////    NSLog(@"newDateString %@", newDateString);
////    [outputFormatter release];
//    
//    NSDate *dateNow = [outputFormatter dateFromString:newDateString];
//    
//    NSDate* currentDate = [NSDate date];
//    NSTimeZone* currentTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
//    NSTimeZone* nowTimeZone = [NSTimeZone systemTimeZone];
//    
//    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:currentDate];
//    NSInteger nowGMTOffset = [nowTimeZone secondsFromGMTForDate:currentDate];
//    
//    NSTimeInterval interval = nowGMTOffset - currentGMTOffset;
//    NSDate* nowDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:currentDate];
//
//    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    self.now = [[NSDate alloc] init];
//    self.targetDate = self.pickerView.date;
//    
//    self.comps = [calendar components:(NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:dateNow toDate:self.targetDate options:0];
//    
//    self.totalSecondsLeft = self.comps.day * 86400 + self.comps.hour * 3600 + self.comps.minute * 60;
//    //self.totalSecondsLeft = [self.now timeIntervalSinceDate:self.targetDate];
//    [self startTimerMethod];
//    
//    [self makeTimeLabel];
}

//- (void)startTimerMethod {
//    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLabel:) userInfo:nil repeats:YES];
//}
//
//- (void)updateLabel:(NSTimer *)timer {
//    [self makeTimeLabel];
//    
//    if (self.totalSecondsLeft > 0) {
//        (self.totalSecondsLeft--);
//    } else {
//        [timer invalidate];
//
//    }
//}

//- (void)makeTimeLabel {
//    NSInteger days     = [self.comps day];
//    NSInteger months   = [self.comps month];
//    NSInteger years    = [self.comps year];
//    NSInteger hours    = [self.comps hour];
//    NSInteger minutes  = [self.comps minute];
//    NSInteger seconds  = [self.comps second];
//    NSString *countdownText = [NSString stringWithFormat:@"%d Days %d:%d:%d", days, hours, minutes,seconds];
//    
    
    
//    NSInteger daysLeft = self.totalSecondsLeft / 86400;
//    //NSInteger hoursLeft = self.totalSecondsLeft / 3600;
//    //NSInteger hoursLeft = (self.totalSecondsLeft / 24) % 3600;
//    NSInteger hoursLeft = self.totalSecondsLeft / 3600 % 24;
//    NSInteger minutesLeft = (self.totalSecondsLeft % 3600) / 60;
//    NSInteger secondsLeft = ((self.totalSecondsLeft % 3600) % 60) % 60;
//    
//    NSString *daysToBeShown = [NSString stringWithFormat:@"%ld", (long)daysLeft];
//    NSString *hoursToBeShown = [NSString stringWithFormat:@"%ld", (long)hoursLeft];
//    NSString *minutesToBeShown = @"";
//    NSString *secondsToBeShown = @"";
//    
//    if (minutesLeft < 10 && minutesLeft != 0) {
//        minutesToBeShown = [NSString stringWithFormat:@"0%ld", (long)minutesLeft];
//    } else if (minutesLeft == 0) {
//        minutesToBeShown = @"00";
//    } else minutesToBeShown = [NSString stringWithFormat:@"%ld", (long)minutesLeft];
//    
//    if (secondsLeft < 10 && secondsLeft != 0) {
//        secondsToBeShown = [NSString stringWithFormat:@"0%ld", (long)secondsLeft];
//    } else if  (secondsLeft == 0) {
//        secondsToBeShown = @"00";
//    } else {
//        secondsToBeShown = [NSString stringWithFormat:@"%ld", (long)secondsLeft];
//    }
//    
//    // if total seconds left is less than 1 hour (1 hour = 3600 seconds), only display minutes and seconds = 00:00 instead of 00:00:00
//    if (self.totalSecondsLeft < 3600) {
//        self.timerLabel.text = [NSString stringWithFormat:@"%@:%@", minutesToBeShown, secondsToBeShown];
//    } else {
//        self.timerLabel.text = [NSString stringWithFormat:@"%@:%@:%@:%@", daysToBeShown, hoursToBeShown, minutesToBeShown, secondsToBeShown];
//    }
//}

-(void)updateTime
{
    //Get the time left until the specified date
    NSInteger ti = ((NSInteger)[self.pickerView.date timeIntervalSinceNow]);
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600) % 24;
    NSInteger days = (ti / 86400);
    
    //Update the label with the remaining time
    self.timerLabel.text = [NSString stringWithFormat:@"%02li days %02li hrs %02li min %02li sec", (long)days, (long)hours, (long)minutes, (long)seconds];
}





#pragma mark - tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return self.event.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventIdentifier" forIndexPath:indexPath];
    
    //    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.laps.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Event %ld", [self.event count] - (long)indexPath.row];
    cell.detailTextLabel.text = self.event[[self.event count] -1 - indexPath.row];
    
    //    cell.textLabel.text = [NSString stringWithFormat:@"Lap %ld", (long)indexPath.row];
    //    cell.detailTextLabel.text = self.laps[indexPath.row];
    
    
    return cell;
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
