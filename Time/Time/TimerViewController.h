//
//  TimerViewController.h
//  Time
//
//  Created by Chris David on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerViewController : UIViewController {
    
    float mainFloat;
    IBOutlet UILabel *seconds;
    NSTimer *timer;
}

- (IBAction)Start;

@end
