//
//  TimerData.h
//  Time
//
//  Created by Felicia Weathers on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerData : NSObject

@property (nonatomic) NSMutableArray *presets;


@property (nonatomic)NSString *nameOfTimer;
@property (nonatomic)NSNumber *presetTime;

@end
