//
//  StopwatchViewController.m
//  Time
//
//  Created by Chris David on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopwatchViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface StopwatchViewController ()
- (void)configureView;
//Music Player
@property (nonatomic)AVAudioPlayer *myMusic;

//Video Player
@property (nonatomic)MPMoviePlayerController *myPlayer;
//UI Buttons and Views
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
- (IBAction)soundButton:(id)sender;
//Timers and stuff
@property (nonatomic) NSTimer *stopTimer;
@property (nonatomic) NSTimer *lapTimer;
@property (nonatomic) NSDate *startDate;
@property (nonatomic) NSDate *previousFireDate;
@property (nonatomic) NSDate *restartDate;
@property (nonatomic) BOOL running;


@property (nonatomic) NSTimeInterval pauseTimeInterval;
@property (nonatomic) NSTimeInterval totalElapsedTime;
@property (nonatomic) NSTimeInterval totalLapTime;

@property (nonatomic) NSDate *previousTime;
@property (nonatomic) NSDate *previousLapTime;



@end

@implementation StopwatchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //Start Lablels Display on Screen
    self.stopwatchLabel.text = @"00.00.00";
    self.lapLabel.text =@"00.00.00";
    self.running = FALSE;
    
    //Stop Watch Label Custom Design
    
    self.stopwatchLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    self.stopwatchLabel.layer.borderWidth = 0.5;
    self.stopwatchLabel.layer.cornerRadius = 15;
    //Start Button
    
    self.startButton.layer.cornerRadius = 37.5;
    self.startButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.startButton.layer.borderWidth = 1.0;
    self.startButton.clipsToBounds = YES;
    
    //Reset Button
    
    self.resetButton.layer.cornerRadius = 37.5;
    self.resetButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.resetButton.layer.borderWidth = 1.0;
    self.resetButton.clipsToBounds = YES;
    
    //Lap Table View At the Buttom
    
    self.lapTableView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.lapTableView.layer.borderWidth = 0.5;
   [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    self.scrollView.contentInset = UIEdgeInsetsZero;
   
    
    // Initialize Date
    [self configureView];
    
    // Scroll Image in background
    
//    UIImage *backgroundImage = [UIImage imageNamed:@"track"];
//    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
//    self.scrollView.contentSize = backgroundImage.size;
//    [self.scrollView addSubview:backgroundImageView];
//    
    // Music
    // Construct URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/Wat.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    self.myMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];

    //Video in Background
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"Video" withExtension:@"mp4"];
    self.myPlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    self.myPlayer.controlStyle = MPMovieControlStyleNone;
    //[self.myPlayer prepareToPlay];
    [self.myPlayer.view setFrame: CGRectMake(0, -500, 2000, 1600)];
    [self.view addSubview:self.myPlayer.view];
    [self.view sendSubviewToBack:self.myPlayer.view];
}

- (void)configureView
{
    self.dataArray = [[NSMutableArray alloc] init];
}
     //WHEN START BUTTON IS TAPPED
- (IBAction)startButton:(id)sender {
   
    if(!self.running) {
        //When App is Not running, Run app and perform these things
        self.previousTime = [NSDate date];
        self.previousLapTime = [NSDate date];
        
       [self.myMusic play];
[self.myPlayer prepareToPlay];
        [self.myPlayer play];
       
        
        [self startTimer];
        self.running = TRUE;
    } else{
        [self pauseTimer];
        self.running = NO;
        
        [self.myMusic pause];
        [self.myPlayer pause];
    }

}

- (void)startTimer {
     // change the
    [self.startButton setTitle:@"Pause" forState:UIControlStateNormal];
    [self.resetButton setTitle:@"Lap" forState:UIControlStateNormal];
   
    self.stopTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                      target:self
                                                    selector:@selector(updateTimer)
                                                    userInfo:nil
                                                     repeats:YES];
    self.lapTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                     target:self
                                                   selector:@selector(rememberTimer)
                                                   userInfo:nil
                                                    repeats:YES];
   
    
}

- (void)pauseTimer {
    

    if(!self.running){
        self.running = TRUE;
  
        [self.resetButton setTitle:@"Lap" forState:UIControlStateNormal];
        
        if (self.stopTimer == nil && self.lapTimer == nil) {
            self.stopTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                              target:self
                                                            selector:@selector(updateTimer)
                                                            userInfo:nil
                                                             repeats:YES];
            self.lapTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                             target:self
                                                           selector:@selector(rememberTimer)
                                                           userInfo:nil
                                                            repeats:YES];
            
        }
    }else{
        self.running = FALSE;
       
        [self.resetButton setTitle:@"Reset" forState:UIControlStateNormal];
        [self.stopTimer invalidate];
        self.stopTimer = nil;
        [self.lapTimer invalidate];
        self.lapTimer = nil;
        
        
        
        
    }
    

    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.resetButton setTitle:@"Reset" forState:UIControlStateNormal];
    
    [self.stopTimer invalidate];
    [self.lapTimer invalidate];
    
    self.stopTimer = nil;
    self.lapTimer = nil;

}

-(void)updateTimer{
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval totalElapsedTime = [[NSDate date] timeIntervalSinceDate:self.previousTime];
    NSTimeInterval lapElapsedTime = [[NSDate date] timeIntervalSinceDate:self.previousLapTime];
    self.previousTime = currentDate;
    self.previousLapTime = currentDate;
    
    self.totalElapsedTime += totalElapsedTime;
    self.totalLapTime += lapElapsedTime;
    
    self.lapLabel.text = [self formattedTime:self.totalLapTime];
    self.stopwatchLabel.text = [self formattedTime:self.totalElapsedTime];


}

- (NSString *)formattedTime:(NSTimeInterval)time {
    //NSTimeInterval wrappedSeconds = fmod(time, 60.0);
    NSTimeInterval minutes = floor(time / 60);
   

    return [NSString stringWithFormat:@"%0.2f:%0.2f",minutes, time];
}

-(void)rememberTimer{
    

}


- (IBAction)resetButton:(id)sender {
    // set totalElapsedTime = 0
    // invalidate all timers
    // reload lap table view with empty array

    


    if (self.running) {
        
        [self.dataArray addObject:[NSString stringWithFormat:@"%.02f", self.totalLapTime]];
        self.totalLapTime = 0;
        self.previousLapTime = [NSDate date];
         [self.lapTableView reloadData];
   
 
    }else{
        self.totalElapsedTime = 0;
        self.totalLapTime = 0;

        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        [self.stopTimer invalidate];
        [self.lapTimer invalidate];
        self.stopwatchLabel.text = @"00.00.00";
        self.lapLabel.text = @"00.00.00";
        [self.dataArray removeAllObjects];
        [self.lapTableView reloadData];
        self.myMusic.currentTime = 0;
          self.myPlayer.currentPlaybackTime = 0;
        
    }

}






// Segue




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *labelID = @"LapLabelCellIdentifier";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:labelID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:labelID];
    }
    cell.detailTextLabel.text = [self.dataArray objectAtIndex: [self.dataArray count] - indexPath.row - 1];
    
    NSString *rowCounter = [NSString stringWithFormat:@"Lap %ld",[self.dataArray count] -(long)indexPath.row];
    cell.textLabel.text = rowCounter;
    
    return cell;
}




- (IBAction)soundButton:(id)sender {
    
         self.myMusic.volume = 0;
    
}
@end
