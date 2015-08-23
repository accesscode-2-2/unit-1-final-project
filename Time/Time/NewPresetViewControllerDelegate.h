//
//  NewPresetViewControllerDelegate.h
//  Time
//
//  Created by Elber Carneiro on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewPresetViewControllerDelegate <NSObject>
- (void)presetCreated:(NSArray *)countdownTime withName:(NSString *)timerName;
@end
