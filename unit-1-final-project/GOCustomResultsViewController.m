//
//  GOCustomResultsViewController.m
//  unit-1-final-project
//
//  Created by Fatima Zenine Villanueva on 8/26/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "GOCustomResultsViewController.h"
#import "Workout.h"
#import "WorkoutManager.h"

@interface GOCustomResultsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *exerciseTimeLabel;
@property (nonatomic) NSInteger totalTime;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) Exercises *exercise;

@end

@implementation GOCustomResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.timer invalidate];

    // timer for the workout to go down
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(updateExerciseTimer)
                                                userInfo:nil
                                                 repeats:YES];
    

    // Creates an index for the number of exercises in the workout
    if (self.currentExerciseIndex == (NSInteger)nil){
        self.currentExerciseIndex = 0;
    }
//    self.exercise = [self.resultsWorkout.exercises objectAtIndex: 0];
//    NSLog(@"%@", self.exercise);
    
    self.exercise = [self.resultsWorkout.exercises objectAtIndex: (NSUInteger)self.currentExerciseIndex];
    
    // Time of exercises
    NSLog(@"exercse time%f", self.exercise.exerciseTime);
    
    int totalTime = self.exercise.exerciseTime;
    self.totalTime = totalTime;
    
    // Exercise names
    NSString *nameOfExercise = self.exercise.nameOfExercise;

    // Sets the name and time to labels
    self.totalTimeLabel.text = @(self.totalTime).stringValue;
    self.exerciseNameLabel.text = nameOfExercise;
    
    self.synthesizer = [[AVSpeechSynthesizer alloc]init];

}

- (void)updateExerciseTimer{
    NSInteger numberOfExercises = [self.resultsWorkout.exercises count];
    NSInteger one = 1.0;
    NSInteger currentExerciseTime =  self.totalTime;
    NSInteger nextNumber = currentExerciseTime - one;
    self.totalTime = nextNumber;
    NSLog(@"%lu", nextNumber);
    NSInteger seconds = nextNumber % 60;
    NSInteger minutes = (nextNumber / 60) % 60;
    NSString *secondsString = @(seconds).stringValue;
    NSString *minutesString = @(minutes).stringValue;
    self.totalTimeLabel.text = [NSString stringWithFormat:@"minutes: %@   seconds: %@", minutesString, secondsString];
    if (self.totalTime == 0 && self.currentExerciseIndex < numberOfExercises - 1){
        NSLog(@"Total exercises: %lu", numberOfExercises);
        NSLog(@"Current exercise index: %lu", self.currentExerciseIndex);
        
        NSLog(@"Next exercise");
        GOCustomResultsViewController *nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomWorkoutView"];
        nextViewController.resultsWorkout = self.resultsWorkout;
        nextViewController.currentExerciseIndex = self.currentExerciseIndex+1;
        NSLog(@"%@", nextViewController.resultsWorkout.exercises);
        NSLog(@"Next exercise index: %lu", nextViewController.currentExerciseIndex);
        
        [self.timer invalidate];
        
        NSLog(@"Still working here");
        [self.navigationController pushViewController:nextViewController animated:YES];
    }
    else if (nextNumber == 0 && self.currentExerciseIndex == numberOfExercises - 1) {
        [self.timer invalidate];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
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
