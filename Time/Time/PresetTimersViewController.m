//
//  PresetTimersViewController.m
//  Time
//
//  Created by Lauren Caponong on 8/20/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "PresetTimersViewController.h"


@interface PresetTimersViewController ()
//<ViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *timeEndingLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *startButtonTapped;
@property (weak, nonatomic) IBOutlet UIButton *stopButtonTapped;

@property (nonatomic) NSTimer *countDownTimer;
@property (nonatomic) NSInteger totalSeconds;
@property (nonatomic) NSInteger unformattedSeconds;

@property (nonatomic) int hours;
@property (nonatomic) int minutes;
@property (nonatomic) int seconds;
@property (nonatomic) NSString *timeFormatted;

@property (nonatomic) NSMutableDictionary *customTimersDictionary;

@property (weak, nonatomic) IBOutlet UITableView *customTimersTableViewList;

@end


@implementation PresetTimersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customTimersTableViewList.delegate = self;
    
    self.customTimersTableViewList.dataSource = self;
    
    self.customTimersDictionary = [[NSMutableDictionary alloc] init];
    
    self.timeEndingLabel.hidden = YES;
    self.alarmNameLabel.hidden = YES;

    
}

- (void)tableView:(UITableView * )tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.countDownTimer invalidate];

    NSArray *keys = [self.customTimersDictionary allKeys];
    NSString *key = [keys objectAtIndex:indexPath.row];
    NSArray *value = [self.customTimersDictionary objectForKey:key];

    self.alarmNameLabel.text = [NSString stringWithFormat:@"%@", key];
    
    self.timeEndingLabel.text = [NSString stringWithFormat:@"%@ seconds", [self.customTimersDictionary objectForKey:key]];

    NSTimeInterval duration = [[self.customTimersDictionary objectForKey:key] doubleValue];
    self.totalSeconds = duration;

    self.alarmNameLabel.hidden = NO;
    self.timeEndingLabel.hidden = NO;
    
}



-(void)viewWillAppear:(BOOL)animated {

    [self.customTimersTableViewList reloadData];

}


- (IBAction)addTimerButtonTapped:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NewCustomTimerViewController *newPresetVC = [storyboard instantiateViewControllerWithIdentifier:@"newPresetVC"];
    
    
    newPresetVC.customTimersDictionary = self.customTimersDictionary;
    
    [self presentViewController:newPresetVC animated:YES completion:nil];
    
}


- (void) timer {
    
    self.totalSeconds = self.totalSeconds - 1;
    NSLog(@"%ld", (long)self.totalSeconds);
    if (self.totalSeconds == 0) {
        [self.countDownTimer invalidate];
    }
}


- (NSString *)timeFormatted:(int)totalSeconds
{
    
    NSString *timeFormatDisplay;
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    timeFormatDisplay = [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
    return timeFormatDisplay;
}


- (IBAction)startButtonTapped:(id)sender {

    if([self.customTimersDictionary count] == 0) {

        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Warning"
                                                    message:@"You must add a new timer first."
                                                    delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [alert show];
        
    } else {
        
        [self startTimer];
        
    }

    
   //
}


-(void) startTimer {
    [self.countDownTimer invalidate];
    
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    self.timeEndingLabel.text = [self timeFormatted:self.totalSeconds];
    
    
    
}


- (void)timerFired:(NSTimer *)timer {
    self.totalSeconds--;
    self.timeEndingLabel.text = [self timeFormatted:self.totalSeconds];
    
    if (self.totalSeconds == 0) {
        [self.countDownTimer invalidate];
        
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Alarm"
                                                         message:@"Your time is up"
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
        [alert show];
    }

}


- (IBAction)stopButtonTapped:(id)sender {
    
    [self.countDownTimer invalidate];
    
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this
        
        NSArray *keys = [self.customTimersDictionary allKeys];
        
        NSString *key = keys[indexPath.row];
        
        [self.customTimersDictionary removeObjectForKey:key];
        
        self.alarmNameLabel.hidden = YES;
        self.timeEndingLabel.hidden = YES;
        
        [tableView reloadData]; // tell table to refresh now
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.customTimersDictionary count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customTimersCellIdentifier" forIndexPath:indexPath];

    NSArray *keys = [self.customTimersDictionary allKeys];
    NSString *key = keys[indexPath.row];
    
    //ALARM NAME LABEL TEXT
    if ([key isEqual: @""]) {
        self.alarmNameLabel.text = @"Untitled";
    } else {
        self.alarmNameLabel.text = [NSString stringWithFormat:@"%@", key];
    }
    
    //CELL - ALARM LABEL TEXT
    if ([key isEqual: @""]) {
        cell.textLabel.text = @"Untitled";
    } else {
        cell.textLabel.text = key;
    }
    
    //CELL - TIME ENDING DETAIL TEXT
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ seconds", [self.customTimersDictionary objectForKey:key]];

    
    //TIME ENDING LABEL TEXT
    self.timeEndingLabel.text = [NSString stringWithFormat:@"%@ seconds", [self.customTimersDictionary objectForKey:key]];
    
    return cell;
    
    
}



@end
