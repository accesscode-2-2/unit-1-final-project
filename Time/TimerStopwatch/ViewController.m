
//  ViewController.m
//  PresetTimerPracticeProject
//
//  Created by Bereket  on 8/29/15.
//  Copyright (c) 2015 Bereket . All rights reserved.
//

#import "ViewController.h"
#import "PresetTimersTableViewController.h"
#import "PresetTimersSingleton.h"

@interface ViewController ()

@end

@implementation ViewController


- (IBAction)setActivityAndTime:(id)sender {
    
    PresetTimer* myTimer= [[PresetTimer alloc] init];
    myTimer.timerName=self.textField.text;
    myTimer.timeInterval= self.datePicker.countDownDuration;
    
    [[PresetTimersSingleton sharedInstance].presetTimersArray addObject:myTimer];
    
    NSLog(@"%f", self.datePicker.countDownDuration);
}


//
//
//
//
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.timeTableButton addTarget:self action:@selector(pushPresetTimersViewController:) forControlEvents:UIControlEventTouchUpInside];
    
//    self.arrayForTimes= [[NSMutableArray alloc] init];
//    
//    // Do any additional setup after loading the view, typically from a nib.
//    
//    self.timerPickerView.delegate=self;
//    self.timerPickerView.dataSource=self;
//    self.pickerViewArrayHours= @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24"];
//    
//    self.minAndSecArray= [NSMutableArray arrayWithCapacity:60];
//    
//    for(int counter= 0; counter<=60; counter++){
//        
//        self.minAndSecArray[counter] = [NSString stringWithFormat:@"%d",counter];
//        
//        
//    }
//    
//    
//    self.myStoredTimeFromPickerView= [[NSMutableArray alloc] initWithObjects:@00,@00,@00, nil];
}
//
////returns the number of pickers
//-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
//    return 3;
//}
//
//
////return the number of picker rows in each picker
//-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
//    
//    if (component == 0) {
//        return self.pickerViewArrayHours.count;
//    }
//    else if(component == 1) {
//        return 60;
//    }
//    else if(component == 2){
//        return 60;
//    }
//    
//    else {
//        NSLog(@"WTH? :/ ");
//        return 0;
//    }
//    
//    
//    
//    
//}
//
//-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    if (component==0){
//        
//        return self.pickerViewArrayHours[row];
//    }
//    else{
//        
//        return self.minAndSecArray[row];
//    }
//}
//
//
//- (IBAction)storeTimeFromPickerInAnArray:(id)sender {
//    
//    
//    
//    
//    
//    
//    
//    NSInteger selectedHourComponent = [self.timerPickerView selectedRowInComponent:0];
//    NSString *hourString = self.pickerViewArrayHours[selectedHourComponent];
//    
//    NSInteger selectedMinuteComponent = [self.timerPickerView selectedRowInComponent:1];
//    NSString *minuteString = self.minAndSecArray[selectedMinuteComponent];
//    
//    NSInteger selectedSecondComponent = [self.timerPickerView selectedRowInComponent:2];
//    NSString *secondString = self.minAndSecArray[selectedSecondComponent];
//    
//    self.timeString = [NSString stringWithFormat:@"%@:%@:%@", hourString, minuteString, secondString];
//    
//    
//    
//    
//    NSLog(@"%@", self.timeString);
//}
//
//-(void)trackCountdown{
//    
//}
//
//
//
//
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    
//    
//    
//    if ([[segue identifier] isEqualToString: @"segueToTableViewIdentifier"]) {
//        [self.arrayForTimes addObject:self.timeString];
//        PresetTimersTableViewController *tableViewController = (PresetTimersTableViewController *)[segue destinationViewController];
//        tableViewController.arrayOfTimes = self.arrayForTimes;
//        
//        
//        NSLog(@"%@", tableViewController.transferredTimeString);
//    }
//    
//}
////
////    PresetTimersTableViewController* PresetTimersTableViewControllerInstance= [[PresetTimersTableViewController alloc] init];
//
////
////    PresetTimersTableViewControllerInstance.transferredTimeString=self.timeString;
////    PresetTimersTableViewController *PresetTimersViewController = (PresetTimersTableViewController *)[segue destinationViewController];
////
//
//// Get the new view controller using [segue destinationViewController].
//// Pass the selected object to the new view controller.
//
//
//
//
////- (NSInteger)selectedRowInComponent:(NSInteger) component{
////
////    return component;
//=======
////#import "ViewController.h"
//////#import "NSTimersForTableViews.h" // what is this? can't find a viewcontroller for this
////#import "PresetTimersTableViewController.h"
////
////@interface ViewController ()
////
////@end
////
////@implementation ViewController
////
////
////
////
////- (void)viewDidLoad {
////    [super viewDidLoad];
////    self.arrayForTimes= [[NSMutableArray alloc] init];
////    
////    // Do any additional setup after loading the view, typically from a nib.
////    
////    self.timerPickerView.delegate=self;
////    self.timerPickerView.dataSource=self;
////    self.pickerViewArrayHours= @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24"];
////    
////    self.minAndSecArray= [NSMutableArray arrayWithCapacity:60];
////    
////    for(int counter= 0; counter<=60; counter++){
////        
////        self.minAndSecArray[counter] = [NSString stringWithFormat:@"%d",counter];
////        
////        
////    }
////    
////    
////    self.myStoredTimeFromPickerView= [[NSMutableArray alloc] initWithObjects:@00,@00,@00, nil];
////}
////
//////returns the number of pickers
////-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
////    return 3;
////}
////
////
//////return the number of picker rows in each picker
////-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
////    
////    if (component == 0) {
////        return self.pickerViewArrayHours.count;
////    }
////    else if(component == 1) {
////        return 60;
////    }
////    else if(component == 2){
////        return 60;
////    }
////    
////    else {
////        NSLog(@"WTH? :/ ");
////        return 0;
////    }
////    
////    
////    
////    
////}
////
////-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
////    if (component==0){
////        
////        return self.pickerViewArrayHours[row];
////    }
////    else{
////        
////        return self.minAndSecArray[row];
////    }
////}
////
////
////- (IBAction)storeTimeFromPickerInAnArray:(id)sender {
////    
////    
////    
////    
////    
////    
////    
////    NSInteger selectedHourComponent = [self.timerPickerView selectedRowInComponent:0];
////    NSString *hourString = self.pickerViewArrayHours[selectedHourComponent];
////    
////    NSInteger selectedMinuteComponent = [self.timerPickerView selectedRowInComponent:1];
////    NSString *minuteString = self.minAndSecArray[selectedMinuteComponent];
////    
////    NSInteger selectedSecondComponent = [self.timerPickerView selectedRowInComponent:2];
////    NSString *secondString = self.minAndSecArray[selectedSecondComponent];
////    
////    self.timeString = [NSString stringWithFormat:@"%@:%@:%@", hourString, minuteString, secondString];
////    
////    
////    
////    
////    NSLog(@"%@", self.timeString);
//>>>>>>> 91cf5c3db81ea2f2634d11614d5286afa2bd7d23
////}
////
////-(void)trackCountdown{
////    
////}
////
////
////
////
////

- (void)pushPresetTimersViewController:(id)sender {
    PresetTimersTableViewController *tableViewController = [[PresetTimersTableViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:tableViewController animated:YES];
    
    NSLog(@"%@", tableViewController.transferredTimeString);

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    
    
    if ([[segue identifier] isEqualToString: @"showPresetTimersIdentifier"]) {
//        [self.arrayForTimes addObject:self.timeString];
        PresetTimersTableViewController *tableViewController = (PresetTimersTableViewController *)[segue destinationViewController];
//        tableViewController.arrayOfTimes = self.arrayForTimes;
        
        NSLog(@"%@", tableViewController.transferredTimeString);
    }
    
}
//
//////    PresetTimersTableViewController* PresetTimersTableViewControllerInstance= [[PresetTimersTableViewController alloc] init];
////
//////
//////    PresetTimersTableViewControllerInstance.transferredTimeString=self.timeString;
//////    PresetTimersTableViewController *PresetTimersViewController = (PresetTimersTableViewController *)[segue destinationViewController];
//////
////
////// Get the new view controller using [segue destinationViewController].
////// Pass the selected object to the new view controller.
////
////
////
////
//////- (NSInteger)selectedRowInComponent:(NSInteger) component{
//////
//////    return component;
//////}
////
////- (void)didReceiveMemoryWarning {
////    [super didReceiveMemoryWarning];
////    // Dispose of any resources that can be recreated.
////}

@end
