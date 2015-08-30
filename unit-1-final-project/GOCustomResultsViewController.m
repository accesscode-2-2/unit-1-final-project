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
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *endButton;

@end

@implementation GOCustomResultsViewController

- (void)viewWillAppear:(BOOL)animated{
   [self.navigationController setNavigationBarHidden:YES];
    NSUInteger seconds = (NSUInteger)(self.totalTime % 60);
    NSUInteger minutes = (NSUInteger)(self.totalTime / 60) % 60;
    self.totalTimeLabel.text = [NSString stringWithFormat:@" %02lu : %02lu", minutes, seconds];
}

- (void) initializeMainTimer {
    // timer for the workout to go down
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(updateExerciseTimer)
                                                userInfo:nil
                                                 repeats:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.timer invalidate];

    [self initializeMainTimer];
    

    // Creates an index for the number of exercises in the workout
    if (self.currentExerciseIndex == (NSInteger)nil){
        self.currentExerciseIndex = 0;
    }
    
    
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
    NSUInteger seconds = (NSUInteger)(nextNumber % 60);
    NSUInteger minutes = (NSUInteger)(nextNumber / 60) % 60;
    self.totalTimeLabel.text = [NSString stringWithFormat:@" %02lu : %02lu", minutes, seconds];
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

- (IBAction)pauseButton:(UIButton *)sender {
    [self.timer invalidate];
    self.continueButton.hidden = NO;
    self.pauseButton.hidden = YES;
    
}

- (IBAction)continueButton:(UIButton *)sender {
    self.pauseButton.hidden = NO;
    self.continueButton.hidden = YES;
    [self initializeMainTimer];
    
}

- (IBAction)stopButton:(UIButton *)sender {
    [self.timer invalidate];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [self.timer invalidate];
}


@end
