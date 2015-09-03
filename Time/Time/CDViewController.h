//
//  CDViewController.h
//  Time
//
//  Created by Christella on 8/31/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDEvents.h"



@protocol NewEventDelegate <NSObject>

-(void) addToTheArrayNewEvent:(CDEvents *)newTimer;


@end
@interface CDViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabe;;
@property (weak, nonatomic) IBOutlet UITextField *countdownTitle;


@property (nonatomic, weak) id <NewEventDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;


- (IBAction)startCountdown:(id)sender;

@end
