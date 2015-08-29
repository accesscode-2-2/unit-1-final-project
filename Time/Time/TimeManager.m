//
//  TimeManager.m
//  Time
//
//  Created by Artur Lan on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimeManager.h"

@implementation TimeManager

+(TimeManager *)shared {
    static dispatch_once_t once;
    static id shared;
    dispatch_once(&once, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

@end
