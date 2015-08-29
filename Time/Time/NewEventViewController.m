//
//  NewEventViewController.m
//  Time
//
//  Created by Elber Carneiro on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "NewEventViewController.h"

@interface NewEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *eventTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *eventDatePicker;
@end

@implementation NewEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)doneButtonTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
