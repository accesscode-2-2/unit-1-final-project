//
//  PresetTimersViewController.h
//  Time
//
//  Created by Lauren Caponong on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewCustomTimerViewController.h"
#import <AudioToolbox/AudioToolbox.h>


@interface PresetTimersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    SystemSoundID playSoundID;
}

-(IBAction) playAudio:(id)sender;


@end

