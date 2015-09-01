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
#import "BackgroundGradient.h"
#import <AVFoundation/AVFoundation.h>

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

-(void)backgroundSetup{
    CAGradientLayer *bgLayer = [BackgroundGradient greenGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
    [self backgroundSetup];
    NSInteger seconds = (self.totalTime % 60);
    NSInteger minutes = (self.totalTime / 60) % 60;
    self.totalTimeLabel.text = [NSString stringWithFormat:@" %02lu : %02lu", (long)minutes, (long)seconds];
}

- (void) initializeMainTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(updateExerciseTimer)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)setUpOfCustomResults {
    if (self.currentExerciseIndex == (NSInteger)nil){
        self.currentExerciseIndex = 0;
    }
    
    self.exercise = [self.resultsWorkout.exercises objectAtIndex: self.currentExerciseIndex];
    
    int totalTime = self.exercise.exerciseTime;
    self.totalTime = totalTime;
    self.totalTimeLabel.text = @(self.totalTime).stringValue;
    
    NSString *nameOfExercise = self.exercise.nameOfExercise;
    self.exerciseNameLabel.text = nameOfExercise;
    
    self.synthesizer = [[AVSpeechSynthesizer alloc]init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.timer invalidate];
    
    [self initializeMainTimer];
    
    [self setUpOfCustomResults];
    
    [self voiceSpeak: @"Begin Exercise"];
}

- (void)updateExerciseTimer{
    NSInteger numberOfExercises = [self.resultsWorkout.exercises count];
    NSInteger one = 1.0;
    NSInteger currentExerciseTime =  self.totalTime;
    NSInteger nextNumber = currentExerciseTime - one;
    self.totalTime = nextNumber;
    NSInteger seconds = (nextNumber % 60);
    NSInteger minutes = (nextNumber / 60) % 60;
    self.totalTimeLabel.text = [NSString stringWithFormat:@" %02lu : %02lu", (long)minutes, (long)seconds];
    if (self.totalTime == 7){
        [self voiceSpeak: @"Exercise Ends in 5 Seconds"];
    }
    if (self.totalTime == 5){
        [self voiceSpeak: @"5"];
    }
    if (self.totalTime == 4){
        [self voiceSpeak: @"4"];
    }
    if (self.totalTime == 3){
        [self voiceSpeak: @"3"];
    }
    if (self.totalTime == 2){
        [self voiceSpeak: @"2"];
    }
    if (self.totalTime == 1){
        [self voiceSpeak: @"1"];
    }
    if (self.totalTime == 0 && self.currentExerciseIndex < numberOfExercises - 1){
        GOCustomResultsViewController *nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomWorkoutView"];
        nextViewController.resultsWorkout = self.resultsWorkout;
        nextViewController.currentExerciseIndex = self.currentExerciseIndex+1;
        [self.timer invalidate];
        [self.navigationController pushViewController:nextViewController animated:YES];
    }
    else if (nextNumber == 0 && self.currentExerciseIndex == numberOfExercises - 1) {
        [self.timer invalidate];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

- (void)voiceSpeak: (NSString *)textToSpeech {
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:textToSpeech];
    utterance.rate = 0.09;
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-au"];
    [self.synthesizer speakUtterance:utterance];
}


@end
