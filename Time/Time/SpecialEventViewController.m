//
//  SpecialEventViewController.m
//  Time
//
//  Created by Felicia Weathers on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "SpecialEventViewController.h"

@implementation SpecialEventViewController

- (IBAction)startButton:(id)sender {
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger preservedComponents = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
    
    self.datePicker.date = [calendar dateFromComponents:[calendar components:preservedComponents fromDate:self.datePicker.date]];
    
    self.datePicker.hidden = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(updateTime)
                                           userInfo:nil
                                            repeats:YES];

}

-(void)updateTime
{

    NSInteger ti = ((NSInteger)[self.datePicker.date timeIntervalSinceNow]);
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600) % 24;
    NSInteger days = (ti / 86400);

    self.countdownLabel.text = [NSString stringWithFormat:@"%02li days %02li hrs %02li min %02li sec", (long)days, (long)hours, (long)minutes, (long)seconds];
}
- (IBAction)resetButton:(id)sender {
    [timer invalidate];
    self.countdownLabel.text = @"00 days 00 hrs 00 min 00 sec";
    self.datePicker.hidden = NO;
}
@end
