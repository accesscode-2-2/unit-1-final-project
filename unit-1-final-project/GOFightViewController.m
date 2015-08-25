//
//  GOFightViewController.m
//  unit-1-final-project
//
//  Created by Jamaal Sedayao on 8/25/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "GOFightViewController.h"

@interface GOFightViewController ()
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property (weak, nonatomic) IBOutlet UILabel *restLabel;
@property (weak, nonatomic) IBOutlet UILabel *roundNumberLabel;
//Buttons
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
//Timer
@property (nonatomic) NSTimer * mainTimer;
@property (nonatomic) NSTimer * restTimer;
@property (nonatomic) NSTimeInterval roundTime;
@property (nonatomic) NSTimeInterval restTime;
@property (nonatomic) int numberOfRounds;
@property (nonatomic) NSString * counterString;
@property (nonatomic) NSString * restString;
//Audio Player
@property (nonatomic) AVAudioPlayer *bellPlayer;



@end

@implementation GOFightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //set round time
    self.roundTime = 15.0;
    
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:self.roundTime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"mm : ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    self.counterString = [dateFormatter stringFromDate:timeDate];
    self.counterLabel.text = self.counterString;
    
    //set rest time
    
    self.restTime = 10.0;
    
    NSDate *restDate = [NSDate dateWithTimeIntervalSince1970:self.restTime];
    // NSDateFormatter *dateFormatterTwo = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@ "mm : ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    self.restString = [dateFormatter stringFromDate:restDate];
    self.restLabel.text = self.restString;
    
    //set Number of Rounds
    self.numberOfRounds = 0;
    self.roundNumberLabel.text = [NSString stringWithFormat:@"%d", self.numberOfRounds];
    
    //Creating AV Files
    
    NSString *path = [NSString stringWithFormat:@"%@/bell.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    self.bellPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
}
- (void) initializeMainTimer {
    
    self.mainTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(updateTimer)
                                                    userInfo:NULL
                                                     repeats:YES];
    
}
- (void) initializeRestTimer {
    
    self.restTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(updateRestTimer)
                                                    userInfo:NULL
                                                     repeats:YES];
    
}

- (void) updateCounterLabel {
    
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:self.roundTime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"mm : ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    self.counterString = [dateFormatter stringFromDate:timeDate];
    self.counterLabel.text = self.counterString;
    
}
- (void) updateRestLabel {
    
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:self.restTime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"mm : ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    self.restString = [dateFormatter stringFromDate:timeDate];
    self.restLabel.text = self.restString;
    
    
}
- (void) updateRoundTime{
    self.roundTime = 15.0;
    [self updateCounterLabel];
}
- (void) updateRestTime{
    self.restTime = 10.0;
    [self updateRestLabel];
}
- (void) updateNumberOfRounds {
    
    self.numberOfRounds ++;
    self.roundNumberLabel.text = [NSString stringWithFormat:@"%d", self.numberOfRounds];
    [self updateRestTime];
    [self updateRoundTime];
}


- (IBAction)startPressed:(UIButton *)sender {
    
    if (self.mainTimer == nil){
        [self initializeMainTimer];
        [self playBellAtRoundStart];
    }
    
}
- (void) updateTimer {
    self.roundTime -= 1;
    [self updateCounterLabel];
    NSLog(@"Time in round: %f",self.roundTime);
    
    if (self.roundTime == 0){
        [self.mainTimer invalidate];
        [self updateNumberOfRounds];
        [self initializeRestTimer];
        [self playBellAtRoundStart];
    }
}
- (void) updateRestTimer {
    self.restTime -= 1;
    [self updateRestLabel];
    NSLog(@"Rest time: %f", self.restTime);
    
    if (self.restTime == 0){
        [self.restTimer invalidate];
        [self initializeMainTimer];
        [self playBellAtRoundStart];
    }
    
}
- (void) playBellAtRoundStart {
    [self.bellPlayer play];
}


@end
