//
//  TimerModel.h
//  Time
//
//  Created by Xiulan Shi on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerModel : NSObject

@property (nonatomic) NSMutableArray *timers;

+ (instancetype)sharedInstance;

- (void)initializeModel;


@end
