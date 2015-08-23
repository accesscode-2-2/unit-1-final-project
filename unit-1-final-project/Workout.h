//
//  Workout.h
//  unit-1-final-project
//
//  Created by Fatima Zenine Villanueva on 8/22/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Exercises.h"

@interface Workout : NSObject

@property (nonatomic) NSMutableArray *exercises;
@property (nonatomic) Exercises *exercise1;
@property (nonatomic) Exercises *exercise2;
@property (nonatomic) Exercises *exercise3;
- (void) initializeData;

@end

