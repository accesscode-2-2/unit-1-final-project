//
//  WorkoutManager.h
//  unit-1-final-project
//
//  Created by Fatima Zenine Villanueva on 8/22/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkoutManager : NSObject

@property (nonatomic,strong) NSMutableArray *workouts;
@property (nonatomic,strong) NSMutableDictionary *calendarDates;

+ (WorkoutManager *) sharedManager;

+ (WorkoutManager *) calendarManager;


@end
