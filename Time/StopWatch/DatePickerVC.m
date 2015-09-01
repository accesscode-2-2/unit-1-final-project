//
//  DatePickerVC.m
//  StopWatch
//
//  Created by MacMan on 8/31/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import "DatePickerVC.h"


@interface DatePickerVC ()

@property NSString *displayTime;

@property (nonatomic,strong)NSDate *fromDate;
@property (nonatomic,strong)NSDate *toDate;

@end

@implementation DatePickerVC

@synthesize fromDate,toDate;

-(NSTimer *) countDownTimer {
    
    return [NSTimer scheduledTimerWithTimeInterval:1.0/100 target:self selector:@selector(countDownTimerMethod) userInfo:nil repeats:YES];
}

-(void) countDownTimerMethod{
    
    //count out miliseconds
    milliseconds = milliseconds -1;
    _milliSecDisplayLabel.text = [NSString stringWithFormat:@"%i",milliseconds];
    
    //if miliseconds == 1000 reset milisecond count and start counting down seconds
    
    if (milliseconds == 0)
        
    {
        seconds = seconds -1;
        _secondsDisplayLabel.text = [NSString stringWithFormat:@"%i",seconds];
        
        milliseconds = 100;
    }
    //if seconds == 60 reset seconds counter and start counting minutes
    
    if (seconds == 0)
        
    {
        minutes = minutes -1;
        _minutesDisplayLabel.text = [NSString stringWithFormat:@"%i",minutes];
        
        seconds = 60;
    }
    
    if (minutes == 0)
        
    {
        hours = hours -1;
        _hoursDisplayLabel.text = [NSString stringWithFormat:@"%i",hours];
        
        minutes = 60;
    }
    
    if (hours == 0)
        
    {
        days = days -1;
        _daysDisplayLabel.text = [NSString stringWithFormat:@"%i",days];
        
        hours = 24;
    }
        _displayTime = [NSString stringWithFormat:@"%02d:%02d:%02d:%02d",days,hours,minutes,seconds];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
//    [formatter setDateFormat:@"EEE, MMM d, ''yy"];
//    [formatter setTimeZone:[NSTimeZone localTimeZone] ];
//    NSString *formDateString = [formatter stringFromDate: self.datePicker.date];
//    NSString *toDateString = [formatter stringFromDate: self.datePicker.date];
//    
//    _fromLabel.text = formDateString;
//    _toLabel.text = toDateString;
//    
//    fromDate = self.datePicker.date;
//    toDate = self.datePicker.date;
    
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

- (IBAction)didChangeDate:(UIDatePicker *)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"EEE, MMM d, ''yy"];
    [formatter setTimeZone:[NSTimeZone localTimeZone] ];
    
    
    NSString * formattedDate = [formatter stringFromDate:self.datePicker.date];
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            _fromLabel.text = formattedDate;
            fromDate = self.datePicker.date;
            
            break;
        case 1:
            _toLabel.text = formattedDate;
            toDate = self.datePicker.date;
            
        default:
            break;
    }
}

- (IBAction)calculateButtonAction:(UIButton *)sender {
    
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    unsigned int unitFlag = NSCalendarUnitDay;
    
    NSDateComponents *components = [calendar components:unitFlag fromDate:fromDate toDate:toDate options:0];
    
    //NSInteger months = [components month];
    
    NSInteger days = [components day];
    self.answerLabel.text = [NSString stringWithFormat:@"Number of Days until selected date is %li",(long)days];
}

@end




