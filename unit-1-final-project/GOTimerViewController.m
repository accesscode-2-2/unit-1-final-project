//
//  GOTimerViewController.m
//  unit-1-final-project
//
//  Created by Jamaal Sedayao on 8/23/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "GOTimerViewController.h"
#import "Exercises.h"

@interface GOTimerViewController ()

@end

@implementation GOTimerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    

    NSLog(@"%@", self.currentWorkout);
    NSLog(@"%@", self.currentWorkout.workoutName);
    NSLog(@"%@", [self.currentWorkout.exercises objectAtIndex:0]);
    
    
    NSUInteger count = [self.currentWorkout.exercises count];
    for (NSUInteger i = 0; i < count; i++) {
        Exercises *thisExercise = [self.currentWorkout.exercises objectAtIndex: i];
        
        //self.currentExerciseTime = thisExercise.exerciseTime;
        self.currentExerciseName = thisExercise.nameOfExercise;
        self.currentExerciseTime = thisExercise.exerciseTime;
        
        NSTimer *exerciseTime = [NSTimer scheduledTimerWithTimeInterval:5.0
                                                          target:self
                                                        selector:@selector(updateExerciseTimer)
                                                        userInfo:nil repeats:YES];

        NSLog(@"%@", self.currentExerciseName);
        NSLog(@"%f", self.currentExerciseTime);
        
    }

}

- (void) updateExerciseTimer {
    NSLog(@"%f", self.currentExerciseTime);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
