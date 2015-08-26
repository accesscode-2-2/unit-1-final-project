//
//  GOCalendarViewController.m
//  unit-1-final-project
//
//  Created by Fatima Zenine Villanueva on 8/24/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "GOCalendarViewController.h"
#import "GOCalendarResults.h"
#import "WorkoutManager.h"

@interface GOCalendarViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *goCalendarDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *goCalendarTextField;
@property (nonatomic) NSString *calendarGoalsString;
@property (nonatomic) NSDateFormatter *formatter;
@property (nonatomic) NSDate *date;
@end

@implementation GOCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // sets the title
    self.title = @"Pick a Goal";
    
    // stores the text field into the string property
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goCalendarButton:(UIButton *)sender {
    
    // calendar string grabs whatever is in the text field
    self.calendarGoalsString = self.goCalendarTextField.text;
    
    // calling calendar dates singleton NSMutableArray to store custom dates
    NSMutableDictionary *calendarDates = [WorkoutManager calendarManager].calendarDates;
    //calendarDates = [[NSMutableDictionary alloc]init];
    
    // custom date is stored as date from UIDatePicker
    self.date = [self.goCalendarDatePicker date];
    
    // calls the NSMutableArray and adds the date
    [calendarDates setObject:self.date forKey:self.calendarGoalsString];
    
    NSLog(@"%@", calendarDates);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    // creates an instance of a view controller for segue
    GOCalendarResults *resultsVC = segue.destinationViewController;
    
    // calls the date property of the VC object and sets it to the custom date
    resultsVC.scheduledDate = self.date;
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
