//
//  TimerViewController.m
//  Time
//
//  Created by Christella on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()

@property (nonatomic) NSMutableArray *presetTimers;
@property (weak, nonatomic) IBOutlet UITableView *timersTableView;
@property (weak, nonatomic) IBOutlet UIDatePicker *timerPickerView;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButtonTapped;
@property (weak, nonatomic) IBOutlet UIButton *pauseButtonTapped;

@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSTimeInterval *timerDuration;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //control dragging from tableview in the storyboard to the timer itself and setting it to its datasource and delegates implements the code below
//    self.timersTableView.dataSource = self;
//    self.timersTableView.delegate = self;
    
//do I need the line of code below?
    //    [self.timersTableView reloadData];
    
    [self.timerLabel setHidden:YES];

    self.presetTimers = [[NSMutableArray alloc] init];
    [self.presetTimers addObject:@"Coffee timer"];
    [self.presetTimers addObject:@"Popcorn timer"];
    
    NSInteger seconds = 60;
    //[self.timerPickerView setDatePickerMode:UIDatePickerModeCountDownTimer];
    [self.timerPickerView setCountDownDuration:seconds];
}

#pragma mark - Table View methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.presetTimers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.timersTableView dequeueReusableCellWithIdentifier:@"TimerCellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [self.presetTimers objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button methods 

- (IBAction)startButtonTapped:(id)sender {
    if(sender == self.startButtonTapped){
        [self.timerLabel setHidden:NO];
        [self.timerPickerView setHidden:YES];
        [sender setTitle:@"Stop" forState: UIControlStateNormal];
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        //self.timerDuration = self.timerPickerView.countDownDuration;
    }
}

- (void)timerFired: (NSTimer *)timer {
    //artur's code
//    self.timerDuration = self.timerDuration - 1;
//    NSInteger secondsCount = self.timerDuration;
//    NSInteger minutes = secondsCount / 60;
//    NSInteger seconds = secondsCount - (minutes * 60);
//    
//    NSString *outputTimer = [NSString stringWithFormat:@"%02u:%02u", minutes, seconds];
//    self.timerLabel.text = outputTimer;
    
    
    //code from the exercise in class
//    NSInteger currentNumber = [self.timerLabel.text integerValue];
//    NSInteger nextNumber = currentNumber + 1;
//    
//    self.timerLabel.text = [NSString stringWithFormat:@"%lu", nextNumber];
//    
//    if (nextNumber == 10) {
//        [timer invalidate];
//    }
//    NSLog(@"Timer fired");
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
