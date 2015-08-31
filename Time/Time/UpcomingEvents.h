//
//  UpcomingEvents.h
//  Time
//
//  Created by Lauren Caponong on 8/31/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpcomingEvents : NSObject

@property (nonatomic) NSString *eventName;

+ (NSDictionary *) upcomingEventsDictionary;

@end
