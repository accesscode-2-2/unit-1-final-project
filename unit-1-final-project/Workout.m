//
//  Workout.m
//  unit-1-final-project
//
//  Created by Fatima Zenine Villanueva on 8/22/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "Workout.h"
#import "Exercises.h"
#import "WorkoutManager.h"


@implementation Workout

- (void) initializeData {
    WorkoutManager *sharedManager = [WorkoutManager sharedManager];
}

- (NSArray *) WorkoutOne {
    Workout *workout1 = [[Workout alloc]init];
    self.exercise1 = [[Exercises alloc]init];
    self.exercise1.nameOfExercise = @"Push-up";
    self.exercise1.exerciseTime = 120.0;
    [workout1.exercises addObject:self.exercise1];
    return workout1.exercises;
}

- (NSArray *) WorkoutTwo {
    Workout *workout2 = [[Workout alloc]init];
    self.exercise2 = [[Exercises alloc]init];
    self.exercise2.nameOfExercise = @"Push-up";
    self.exercise2.exerciseTime = 120.0;
    [workout2.exercises addObject:self.exercise1];
    return workout2.exercises;
}

- (NSArray *) WorkoutThree {
    Workout *workout3 = [[Workout alloc]init];
    self.exercise3 = [[Exercises alloc]init];
    self.exercise3.nameOfExercise = @"Push-up";
    self.exercise3.exerciseTime = 120.0;
    [workout3.exercises addObject:self.exercise1];
    return workout3.exercises;
}

@end


