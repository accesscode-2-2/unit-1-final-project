//
//  WorkoutManager.m
//  unit-1-final-project
//
//  Created by Fatima Zenine Villanueva on 8/22/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "WorkoutManager.h"
#import "Workout.h"
#import "Exercises.h"

@implementation WorkoutManager

#pragma mark Singleton Methods

@synthesize workouts;

+ (WorkoutManager *) sharedManager{
    static WorkoutManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        sharedMyManager.workouts = [[NSMutableArray alloc] init];
       // [sharedMyManager preLoadedWorkouts];
    });
    return sharedMyManager;
}

- (void)preLoadedWorkouts {
    Workout *workout1 = [[Workout alloc] init];
    workout1.exercises = [[NSMutableArray alloc] init];
    
    Exercises *exercise1 = [[Exercises alloc] init];
    exercise1.nameOfExercise = @"pushups";
    exercise1.exerciseTime = 120.0;
    
    Exercises *exercise2 = [[Exercises alloc] init];
    exercise2.nameOfExercise = @"pullups";
    
    [workout1.exercises addObject:exercise1];
    [workout1.exercises addObject:exercise2];
    
    // // //    // create more workouts
    
    
    [[WorkoutManager sharedManager].workouts addObject:workout1];
}


@end
