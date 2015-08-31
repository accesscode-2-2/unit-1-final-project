//
//  DatesViewController.m
//  DatePickerAndComparison
//
//  Created by MacMan on 8/30/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import "DatesViewController.h"

@interface DatesViewController ()
@property (nonatomic,strong)NSDate *fromDate;
@property (nonatomic,strong)NSDate *toDate;


@end

@implementation DatesViewController
@synthesize fromDate,toDate;


-(NSTimer *) countDownTimer {
    
    return [NSTimer scheduledTimerWithTimeInterval:1.0/100 target:self selector:@selector(timerCountDown) userInfo:nil repeats:YES];
}



-(void)timerCountDown{
    
    //count out miliseconds
    milliseconds= milliseconds -1;
    _milliSecDisplayLabel.text = [NSString stringWithFormat:@"%i",milliseconds];
    
    //if miliseconds == 100 reset milisecond count and start counting seconds
    if (milliseconds == 0)
        
    {
        seconds = seconds -1 ;
        _secondsDisplayLabel.text = [NSString stringWithFormat:@"%i",seconds];
        
        milliseconds = 0;
    }
    //if seconds == 60 reset seconds counter and start counting minutes
    if (seconds ==0)
        
    {
        hour = hour - 1;
        _hoursDisplayLabel.text = [NSString stringWithFormat:@"%i",hour];
        seconds = 60;
    }
    countDownDisplayTimer = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,seconds,milliseconds];
}






- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"EEE, MMM d, ''yy"];
    [formatter setTimeZone:[NSTimeZone localTimeZone] ];
    NSString *formDateString = [formatter stringFromDate: self.datePicker.date];
    NSString *toDateString = [formatter stringFromDate: self.datePicker.date];
    
    _fromLabel.text = formDateString;
    _toLabel.text = toDateString;
    
    fromDate = self.datePicker.date;
    toDate = self.datePicker.date;
    
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




