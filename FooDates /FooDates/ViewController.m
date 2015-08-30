//
//  ViewController.m
//  FooDates
//
//  Created by MacMan on 8/29/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode=UIDatePickerModeDateAndTime;
    [self.dateSelectionTextField setInputView:datePicker];
    
    UIToolbar *toolBar =[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320,44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [toolBar setItems:[NSArray arrayWithObjects:space, doneBtn, nil]];
    [self.dateSelectionTextField setInputAccessoryView:toolBar];
    
    
    NSDateFormatter *currentDateformatter = [[NSDateFormatter alloc] init];
    currentDateformatter.dateFormat = @"M.d.YYYY";
    NSString *string = [currentDateformatter stringFromDate:[NSDate date]];
    
    return NSLog(@"%@",string);

    
}

-(void)ShowSelectedDate

{   NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat: @"MM/dd/YYYY hh:min a"];
    self.dateSelectionTextField.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [self.dateSelectionTextField resignFirstResponder];
    
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
