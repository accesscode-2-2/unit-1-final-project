//
//  GOTimerViewController.h
//  unit-1-final-project
//
//  Created by Jamaal Sedayao on 8/23/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercises.h"
#import "Workout.h"
#import "GOWorkoutViewController.h"

@interface GOTimerViewController : UIViewController

@property (nonatomic) Workout *currentWorkout;
@property (nonatomic) Exercises *exercise;
@property (nonatomic) NSString * currentExerciseName;
@property (nonatomic) NSTimeInterval currentExerciseTime;
@property (nonatomic) NSString *currentExerciseImage;

//Properties of ViewController
@property (weak, nonatomic) IBOutlet UIImageView *exerciseImageView;
@property (weak, nonatomic) IBOutlet UILabel *exerciseTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *exerciseNameLabel;


@end
