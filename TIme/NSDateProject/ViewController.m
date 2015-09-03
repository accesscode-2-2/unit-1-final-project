//
//  ViewController.m
//  NSDateProject
//
//  Created by MacMan on 9/1/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import "ViewController.h"
#import "LapNotes.h"
#import <AVFoundation/AVFoundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>


@interface ViewController ()
@property NSString *displayTime;
@property (strong,nonatomic)AVAudioPlayer *dontStopGetItGetIt;


@end
@implementation ViewController

@synthesize laps;
@synthesize lapTableView;


- (void)updateTimer
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:_startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
 
    _stopWatchLabel.text = timeString;
    //[dateFormatter release];
    
}

-(NSTimer *) createTimer {

return [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                  target:self
                                                selector:@selector(updateTimer)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.laps = [[NSMutableArray alloc] init];
    [self.lapTableView reloadData];
    

    
    
    NSString *path = [NSString stringWithFormat:@"%@/dontStop.mp3",[[NSBundle mainBundle]resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    _dontStopGetItGetIt = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];


    }

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.lapTableView reloadData];
}






#pragma mark - Table view data source


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//set number of rows
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.laps count];
}

//create a cell and fill it with info

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     static NSString *SimpleIdentifier = @"lapReuseCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier];
    if (cell ==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleIdentifier];
    }
    cell.textLabel.text = self.laps[indexPath.row];
    return cell;
}

- (IBAction)fBookButtonAction:(UIButton *)sender {
    
     NSLog(@"FBB Tapped");
    NSString* launchUrl = @"http://facebook.com/";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
}

- (IBAction)startStopButtonAction:(id)sender {
    

    if (!_DontStopWatch){
       
    _DontStopWatch = [self createTimer];
    UIImage *startStopImage = [UIImage imageNamed:@"fe_runningStop.png"];
    [_startStopButton setImage:startStopImage forState:UIControlStateNormal];

    UIImage *lapResetImage = [UIImage imageNamed:@"fe_runningLap.png"];
    [_lapResetButton setImage:lapResetImage forState:UIControlStateNormal];
    //gives timer reference point to start
    self.startDate =[NSDate date];

    }
    
    else
    {
    NSLog(@"Stop Tapped");
    [_DontStopWatch invalidate];
    //sound
        [_dontStopGetItGetIt play];
    //sound
   
    UIImage *startImageGreen = [UIImage imageNamed:@"fe_runningStart.png"];
    [_startStopButton setImage:startImageGreen  forState:UIControlStateNormal];

    UIImage *stopImageRed  = [UIImage imageNamed:@"fe_runningStop.png"];
    [_startStopButton setImage:stopImageRed forState:UIControlStateNormal];


    UIImage *restartImageGreen = [UIImage imageNamed:@"fe_runningStart.png"];
    [_startStopButton  setImage:restartImageGreen forState:UIControlStateNormal];


    UIImage *resetImageBlue = [UIImage imageNamed:@"fe_runningReset.png"];
    [_lapResetButton setImage:resetImageBlue forState:UIControlStateNormal];

    }
}

-(IBAction)lapResetButtonAction:(id)sender {
    NSLog(@"reset Tapped");
    // if we have a timer, we want to take a lap
    if (_DontStopWatch) {
       
        
//        NSTimeInterval interval = [now timeIntervalSinceDate:referenceDate];
//        NSLog (@"reference date was %.0f seconds ago", interval);
        
       // self.laps = [NSMutableArray array];
        
        NSDate *now = [NSDate date];

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm:ss.SSS"];
        
        NSDate *todaysDate;
        todaysDate = [NSDate date];
        NSTimeInterval interval = [todaysDate timeIntervalSinceDate:now];
        [laps addObject:[formatter stringFromDate:todaysDate]];
        
        
        NSLog(@"%f",interval);
        
        [self.lapTableView reloadData];
        }

    // there is no timer, so we want to reset
        else {
            self.laps = [NSMutableArray array];
            [self.lapTableView reloadData];
            [_dontStopGetItGetIt stop];
            
            _stopWatchLabel.text = @"00:00:00.000";
        }
    }



@end

