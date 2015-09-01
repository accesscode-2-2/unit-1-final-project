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

    
}

- (void)tableView:(UITableView * )tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected index path %@",indexPath);
    NSArray *keys = [self.customTimersDictionary allKeys];
    NSString *key = [keys objectAtIndex:indexPath.row];
    NSArray *value = [self.customTimersDictionary objectForKey:key];

    self.alarmNameLabel.text = [NSString stringWithFormat:@"%@", key];
    
    self.timeEndingLabel.text = [NSString stringWithFormat:@"%@", [self.customTimersDictionary objectForKey:key]];

    NSTimeInterval duration = [[self.customTimersDictionary objectForKey:key] doubleValue];
    NSLog(@"setting duration to %f", duration);
    self.totalSeconds = duration;

    
}



-(void)viewWillAppear:(BOOL)animated {
    
    NSLog(@"viewwillappear%@", self.customTimersDictionary);

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
    // keep track of the key, say self.currentKey
    // if current key is nil, and there is at least one key
    // then you can set currentKey to allKeys[0]
    
    // if there are no keys at all, don't start the time / crash!
    
    NSLog(@"%@",self.customTimersDictionary);
//
//    NSString *firstKey = [self.customTimersDictionary allKeys][0];
//    NSTimeInterval duration = [self.customTimersDictionary[firstKey] doubleValue];
//    self.totalSeconds = duration;
//
//    if (<#condition#>) {
//        <#statements#>
//    }
//    
    [self startTimer];
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
    
    cell.textLabel.text = key;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ seconds", [self.customTimersDictionary objectForKey:key]];
    
    self.alarmNameLabel.text = [NSString stringWithFormat:@"%@", key];
    
    self.timeEndingLabel.text = [NSString stringWithFormat:@"%@", [self.customTimersDictionary objectForKey:key]];
    
    
    
//
//    self.timeEndingLabel.text = timeFormatDisplay;
//    
//    
//    [NSString stringWithFormat:@"%@", [self.customTimersDictionary objectForKey:key]];
    NSLog(@"%@", [self.customTimersDictionary objectForKey:key]);
//    
//    NSLog(@"%@", [self.customTimersDictionary allKeys]);
    
    return cell;
    
    
}

//#pragma mark - Table view delegate
//
//
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
//    
//}


@end
