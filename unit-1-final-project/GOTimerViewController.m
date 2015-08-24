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

@property (nonatomic) NSTimer *timer;
@property (nonatomic) Exercises *thisExercise;
@end

@implementation GOTimerViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"Exercise Index: %lu", self.currentExerciseIndex);

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(updateExerciseTimer)
                                                userInfo:nil
                                                 repeats:YES];
    
    
    self.thisExercise = [self.currentWorkout.exercises objectAtIndex: (NSUInteger)self.currentExerciseIndex];
    self.currentExerciseName = self.thisExercise.nameOfExercise;
    self.currentExerciseTime = self.thisExercise.exerciseTime;
   
  // Updates based on exercise
    self.exerciseTimeLabel.text = [NSString stringWithFormat:@"%f",self.currentExerciseTime];
    
    self.exerciseNameLabel.text = self.thisExercise.nameOfExercise;
    
    NSString *imageName = self.thisExercise.exerciseImageString;
    UIImageView *view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    self.exerciseImageView.image = view.image;
    
    if (self.currentExerciseIndex == (NSInteger)nil){
        self.currentExerciseIndex = 0;
    }
    
    
    
}

- (void) updateExerciseTimer {
    NSInteger count = [self.currentWorkout.exercises count];
    NSLog(@"%lu", count);
    NSLog(@"%f", self.currentExerciseTime);
    NSInteger one = 1.0;
    NSInteger currentExerciseTime = [self.exerciseTimeLabel.text integerValue];
    NSInteger nextNumber = currentExerciseTime - one;
    self.exerciseTimeLabel.text = [NSString stringWithFormat:@"%lu", nextNumber];
    if (nextNumber == 0 && self.currentExerciseIndex < count - 1) {
        NSLog(@"Next exercise");
        GOTimerViewController *nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WorkoutController"];
        nextViewController.currentWorkout = self.currentWorkout;
        nextViewController.currentExerciseIndex = self.currentExerciseIndex+1;
        [self.timer invalidate];
        [self.navigationController pushViewController:nextViewController animated:YES];
    }
    
    else if (nextNumber == 0 && self.currentExerciseIndex == count - 1) {
        //        if (self.currentExerciseIndex == count){
        //            [self.timer invalidate];
        [self.timer invalidate];
        [self.navigationController popToRootViewControllerAnimated:YES];
        //        }
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
