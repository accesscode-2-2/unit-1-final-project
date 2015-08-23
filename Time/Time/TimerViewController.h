//
//  TimerViewController.h
//  Time
//
//  Created by Elber Carneiro on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresetsTableViewControllerDelegate.h"

@interface TimerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, PresetsTableViewControllerDelegate>
@end
