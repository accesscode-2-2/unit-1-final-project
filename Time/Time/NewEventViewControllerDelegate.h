//
//  NewEventViewControllerDelegate.h
//  Time
//
//  Created by Elber Carneiro on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewEventViewControllerDelegate <NSObject>
- (void)presetCreated:(NSDate *)eventDate withName:(NSString *)eventName;
@end
