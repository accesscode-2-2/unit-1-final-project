//
//  GOCustomResultsViewController.h
//  unit-1-final-project
//
//  Created by Fatima Zenine Villanueva on 8/26/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"
#import <AVFoundation/AVFoundation.h>

@interface GOCustomResultsViewController : UIViewController

@property (nonatomic) Workout *resultsWorkout;
@property (nonatomic) NSInteger currentExerciseIndex;
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;

@end
