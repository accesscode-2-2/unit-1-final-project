//
//  NewPresetViewController.h
//  Time
//
//  Created by Elber Carneiro on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPresetViewControllerDelegate.h"

@interface NewPresetViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic) id<NewPresetViewControllerDelegate> delegate;
@end
