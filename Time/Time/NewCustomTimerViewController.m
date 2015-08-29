//
//  NewCustomTimerViewController.m
//  Time
//
//  Created by Christian Maldonado on 8/26/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "NewCustomTimerViewController.h"
#import "PresetTimersViewController.h"

@interface NewCustomTimerViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *timePickerView;
@property (weak, nonatomic) IBOutlet UITextField *alarmNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (nonatomic) NSDate *chosenDate;

@end

@implementation NewCustomTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.customTimersDictionary setObject:@"TIME is the value" forKey:@"birthday is the KEY"];
    
//    NSLog(@"%@ - printing self.customTimersDictionary here", self.customTimersDictionary);
    
    // Do any additional setup after loading the view.
}


- (IBAction)doneButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSString *alarmName = self.alarmNameLabel.text;
    
//   add object to dictionary
//    [self.customTimersDictionary setObject:alarmName
    
    NSLog(@"%@ is the current alarm name", alarmName);
    
    NSTimeInterval timeInterval = self.timePickerView.countDownDuration;

    NSLog(@"%f is the current time interval", timeInterval);
    
    [self.customTimersDictionary setObject:@(timeInterval) forKey:alarmName];
    
    // something like [self.timerViewController doSomethingWithThisNewTimer]
    
//    [self.timerViewController addTimer:timeInterval];
    
    //break this down into hours and minutes because it's displayed in seconds
    //deligation to comunitcate this info back to the next view controller
    
    /*
     when the user hits 'done' use delegation to provide all timer info back to the 
     presettimersviewcontroller
     
     ex.
     
     NSInteger hours = x;
     NSInteger minutues = x;
     
     [self.delegate newCustomTimeViewController:self didAddTimerWithHours:hours minutes:minutes name:alarmName];
     
     */
    
}


- (IBAction)alarmNameLabel:(id)sender {
    
    //[ViewControllerDelegate updateAlarmLabel];
    
}

- (IBAction)timePickerView:(id)sender {
    
//    NSDate *chosenDate = [self.timePickerView date];
//    NSLog(@"%@ is my chosen date",chosenDate);
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
//    
//    NSString *selected = [self.category.options objectAtIndex:indexPath.row];
//    
//    self.category.selection = selected;
//



@end
