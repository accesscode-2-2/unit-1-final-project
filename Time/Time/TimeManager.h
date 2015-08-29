//
//  TimeManager.h
//  Time
//
//  Created by Artur Lan on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeManager : NSObject

@property (nonatomic) NSMutableDictionary *personalTimer;

+(TimeManager *)shared;

@end
