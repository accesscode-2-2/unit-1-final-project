//
//  BuildWorkout.m
//  unit-1-final-project
//
//  Created by Jamaal Sedayao on 8/28/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "BuildWorkout.h"

@implementation BuildWorkout

-(void) initializeData{
    self.exercises = [[NSDictionary alloc]init];
    
    NSArray *legs = [[NSArray alloc]init];
    NSArray *chest = [[NSArray alloc]init];
    NSArray *back = [[NSArray alloc]init];
    NSArray *arms = [[NSArray alloc]init];
    NSArray *shoulders = [[NSArray alloc]init];

    
            legs = @[
                      @"squat",
                      @"leg press",
                      @"leg curls",
                      @"calf raises",
                      @"leg extension",
                      @"box jumps"
                      ];
    
            chest = @[@"bench press",
                       @"chest fly",
                       @"incline dumbell press",
                       @"push-ups",
                       @"dips",
                       @"cable crossovers"
                       ];
    
    
            back = @[@"dumbell rows",
                      @"lat pulldown",
                      @"deadlifts",
                      @"barbell rows",
                      @"close-grip pulldown",
                      @"pull-ups"
                      ];
    
            arms = @[
                      @"dumbell curls",
                      @"barbell curls",
                      @"tricep pushdown",
                      @"tricep extension",
                      @"tricep kickback",
                      @"hammer curls",
                      @"forearm curls"
                      ];
    
            shoulders = @[
                           @"barbell press",
                           @"arnold press",
                           @"reverse fly",
                           @"side laterals",
                           @"front plate raise"
                           ];

    
    self.exercises = @{
                        @"Legs": legs,
                       @"Chest": chest,
                       @"Back" : back,
                       @"Arms" : arms,
                  @"Shoulders" : shoulders,
                        };
    
}


@end
