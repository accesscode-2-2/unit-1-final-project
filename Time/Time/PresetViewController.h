//
//  PresetViewController.h
//  Time
//
//  Created by Diana Elezaj on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresetViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>  {
    
    IBOutlet UIProgressView *progressView;
}
@property(nonatomic,retain)IBOutlet UIImageView *sandGlass;

 - (IBAction)stopButtonTapped:(UIButton *)sender;


@end
