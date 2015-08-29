//
//  CountdownEventViewController.m
//  Time
//
//  Created by Diana Elezaj on 8/27/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "CountdownEventViewController.h"

@interface CountdownEventViewController ()
@property (nonatomic) NSTimer *countdownTimer;
@property (weak, nonatomic) IBOutlet UIDatePicker *eventPicker;
@property (weak, nonatomic) IBOutlet UILabel *countdownTimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet UITextField *eventTextField;
- (IBAction)startButton:(id)sender;
- (IBAction)stopButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *eventImage;

@end

@implementation CountdownEventViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.eventLabel.hidden = YES;
    self.countdownTimerLabel.hidden = YES;
    self.countdownTimerLabel.text = @"";
    self.eventLabel.text = @"";
    self.eventImage.hidden = YES;
   
    
}
- (IBAction)startButton:(id)sender {
    
    //this will create animation for eventLabel
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.type = kCATransitionFromTop;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.eventLabel.layer addAnimation:animation forKey:@"changeTextTransition"];
    
    /***** interface ***/
    self.countdownTimerLabel.hidden = NO;
    self.eventTextField.hidden = YES;
    
    
    
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                           target:self
                                                         selector:@selector(updateTime)
                                                         userInfo:nil
                                                          repeats:YES];
    if ([self.countdownTimerLabel.text isEqualToString:@"This date has already passed"]) {
        

        
    }

    else {
        
        self.eventImage.hidden = NO;
        self.eventLabel.hidden = NO;
    }
    
    
    NSString *stringEvent = [self.eventTextField text];
    if (([stringEvent rangeOfString:@"Wedding"].location != NSNotFound) || ([stringEvent rangeOfString:@"wedding"].location != NSNotFound)) {
        self.eventImage.image = [UIImage imageNamed:@"wedding"];
        NSLog(@"There is a weddin comming up");
    } else if (([stringEvent rangeOfString:@"Graduation"].location != NSNotFound) || ([stringEvent rangeOfString:@"graduation"].location != NSNotFound)) {
        self.eventImage.image = [UIImage imageNamed:@"graduation"];
        NSLog(@"There is a weddin comming up");
    }
    
    else
    
    {
        NSLog(@"no weddings!");
    }

    if ([[self.eventTextField text]  isEqual: @""])
        self.eventLabel.text = [NSString stringWithFormat: @"Time remaining until your event"];
    else
        self.eventLabel.text = [NSString stringWithFormat: @"Time remaining until \"%@\"", [self.eventTextField text]];
    
    
    
    //get current time on your computer/phone
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    //object that describes the calendrical components required for the computation.
    NSUInteger preservedComponents = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
    //calculate the time distance between selected date, and current date
    self.eventPicker.date = [calendar dateFromComponents:[calendar components:preservedComponents fromDate:self.eventPicker.date]];
    //start countdown timer
    
}

- (IBAction)stopButton:(id)sender {
    [self.countdownTimer invalidate]; //invalidate timer
    self.eventTextField.hidden = NO;
    self.eventImage.hidden = YES;
}

-(void)updateTime
{
    NSInteger timeLeft, years, months, days, hours, minutes, seconds ;
    
    timeLeft = ((NSInteger)[self.eventPicker.date timeIntervalSinceNow]);
    seconds = timeLeft % 60;
    minutes = (timeLeft / 60) % 60;
    hours = (timeLeft / 3600) % 24;
    days = (timeLeft / 86400) % 30;
    months = (timeLeft / 2635200)%12;
    years = (timeLeft /31622400 );
    
    //if seconds is a negative number, it means that the selected date has already passed
    if (timeLeft <= 0) {
        self.countdownTimerLabel.textColor = [UIColor redColor];
        self.countdownTimerLabel.text = @"This date has already passed";
        self.eventImage.hidden = YES;
        self.eventLabel.hidden = YES;

        
    } //if years, months, days are 0, print out only hours, minutes,and sec
    else if (years == 0 && months ==0 && days == 0) {
        self.countdownTimerLabel.textColor = [UIColor blackColor];
        self.countdownTimerLabel.text = [NSString stringWithFormat:@"%02li H %02li min %02li sec", (long)hours, (long)minutes, (long)seconds];
 
    }
    else if (years == 0 && months == 0) {
        self.countdownTimerLabel.textColor = [UIColor blackColor];
        self.countdownTimerLabel.text = [NSString stringWithFormat:@"%02li D %02li H %02li min %02li sec", (long)days, (long)hours, (long)minutes, (long)seconds];
 
    }
    else if (years == 0 ){
        self.countdownTimerLabel.textColor = [UIColor blackColor];
        self.countdownTimerLabel.text = [NSString stringWithFormat:@"%02li M %02li D %02li H %02li min %02li sec",(long) months, (long)days, (long)hours, (long)minutes, (long)seconds];
     }
    else {
        self.countdownTimerLabel.textColor = [UIColor blackColor];
        self.countdownTimerLabel.text = [NSString stringWithFormat:@"%02li Y %02li M %02li D %02li H %02li min %02li sec", (long) years, (long) months, (long)days, (long)hours, (long)minutes, (long)seconds];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
