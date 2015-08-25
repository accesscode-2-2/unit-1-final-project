//
//  GOCalendarViewController.m
//  unit-1-final-project
//
//  Created by Fatima Zenine Villanueva on 8/24/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "GOCalendarViewController.h"

@interface GOCalendarViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *goCalendarDatePicker;
@property (nonatomic) NSDateFormatter *formatter;
@property (weak, nonatomic) IBOutlet UILabel *calendarTimeLabel;
@property (nonatomic) NSDate *date;


@end

@implementation GOCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goCalendarButton:(UIButton *)sender {
//    NSDate *thisdate = [self.goCalendarDatePicker date];
//    NSLog(@"%@", thisdate);
    self.formatter = [NSDateFormatter new]; //save a property of NSDateFormatter type, you'll use this before
    [self.formatter setDateFormat:@"dd:HH:mm:ss"];
    
    self.date = [self.goCalendarDatePicker date]; //save in a property, this will be your start date
    self.calendarTimeLabel.text = [self.formatter stringFromDate: self.date];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(refreshLabel)
                                   userInfo:nil
                                    repeats:YES];
}


-(void)refreshLabel
{
    NSDate *dateCountDown = [NSDate dateWithTimeIntervalSince1970:[self.date timeIntervalSince1970] - 1]; //the start-up date minus 1 sec.
    self.calendarTimeLabel.text = [self.formatter stringFromDate:dateCountDown];
    self.date = dateCountDown;
}
// Forces the text colour of the label to be white only for UIDatePicker and its components

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
