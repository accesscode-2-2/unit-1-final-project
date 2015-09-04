//
//  PresetsTableViewControllerDelegate.h
//  TimerStopwatch
//
//  Created by Charles Kang  on 8/26/15.
//  Copyright (c) 2015 Charles Kang . All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol PresetsTableViewControllerDelegate <NSObject>
- (void)presetTime:(NSArray *)presetTime;
@end
