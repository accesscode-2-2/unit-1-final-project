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
    
    //self.totalSeconds = 120;
    //self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    
    self.customTimersDictionary = [[NSMutableDictionary alloc] init];
    
    
    
    
}




-(void)viewWillAppear:(BOOL)animated {
    
    NSLog(@"viewwillappear%@", self.customTimersDictionary);
//    
//    [self.view setNeedsDisplay];

    [self.customTimersTableViewList reloadData];

}


- (IBAction)addTimerButtonTapped:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NewCustomTimerViewController *newPresetVC = [storyboard instantiateViewControllerWithIdentifier:@"newPresetVC"];
    
    
    newPresetVC.customTimersDictionary = self.customTimersDictionary;
    
    [self presentViewController:newPresetVC animated:YES completion:nil];
    
}

//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // set the timerViewController property on the destination view controller to be self
//    
//}

- (void) timer {
    self.totalSeconds = self.totalSeconds - 1;
    NSLog(@"%ld", (long)self.totalSeconds);
//    timerLabel.text = [self timeFormatted:totalSeconds];
    if (self.totalSeconds == 0) {
        [self.countDownTimer invalidate];
    }
}

//- (void) newCustomTimeViewController:(NewCustomViewController *)customVC didAddTimerWithHours:(NSInteger)hours minutes:(NSInteger)minutes name:(NSString *)alarmName {
    
//}



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
    
    [self.countDownTimer invalidate];
    
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startButtonTapped:) userInfo:nil repeats:NO];
    
    float currentNumber = [self.timeEndingLabel.text floatValue];
    self.totalSeconds = currentNumber - 1;
    self.timeEndingLabel.text = [NSString stringWithFormat:@"%ld", (long)self.totalSeconds];
    
    
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
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [self.customTimersDictionary objectForKey:key]];
    
    self.alarmNameLabel.text = [NSString stringWithFormat:@"%@", key];
    
    
////    // CONVERTING TO READABLE SECONDS / HOURS
////    
//    self.seconds = self.totalSeconds % 60;
//    self.minutes = (self.totalSeconds / 60) % 60;
//    self.hours = self.totalSeconds / 3600;
////    NSString *timeFormatDisplay = [NSString stringWithFormat:@"%02d:%02d:%02d",self.hours, self.minutes, self.seconds];
//
//    
//    
//    self.timeEndingLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",self.hours, self.minutes, self.seconds];

    
self.timeEndingLabel.text = [NSString stringWithFormat:@"%@", [self.customTimersDictionary objectForKey:key]];
    
    
    
//
//    self.timeEndingLabel.text = timeFormatDisplay;
    
    [NSString stringWithFormat:@"%@", [self.customTimersDictionary objectForKey:key]];
    NSLog(@"%@", [self.customTimersDictionary objectForKey:key]);
    
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
