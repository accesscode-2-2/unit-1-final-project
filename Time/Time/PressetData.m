//
//  PressetData.m
//  Time
//
//  Created by Diana Elezaj on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "PressetData.h"

@implementation PressetData

+ (PressetData *)sharedModel {
    static PressetData *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        [sharedManager initializeData];
    });
    return sharedManager;
}

-(void)initializeData{
    
    self.presetModel = [[Preset alloc] init];
    
    self.allPresets = @[@"Popcorn 00:03:00",
                        @"Tea      00:02:30",
                        @"Roast Turkey      03:00:00",
                        @"Lounchtime     00:30:00",
                        @"Reheat pizza    00:01:00",
                        @"Workout      00:20:00",
                        @"Sitting Meditation      00:45:00"
                        ].mutableCopy;
}







@end
