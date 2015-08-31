//
//  TimerViewController.m
//  Time
//
//  Created by Elber Carneiro on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerViewController.h"
#import "PresetsTableViewController.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *timerPickerView;
@property (nonatomic) NSMutableArray *hours;
@property (nonatomic) NSMutableArray *minutes;
@property (nonatomic) NSMutableArray *seconds;
@property (nonatomic) NSMutableArray *pickerViewNumbers;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UILabel *timerName;

//For use with UIPickerView
@property (nonatomic) NSTimer *timer;
@property (nonatomic) CFTimeInterval initialTime;
@property (nonatomic) CFTimeInterval lapInitialTime;
@property (nonatomic) NSArray *presetTime;

@property (nonatomic) NSInteger component;
@property (nonatomic) NSInteger row;

@property (nonatomic) BOOL isStarted;
@property (nonatomic) BOOL isInitial;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPickerViewNumbers];
    
    self.timerPickerView.delegate = self;
    self.timerPickerView.dataSource = self;
    self.timerName.text = @" ";
    
    self.isStarted = NO;
    self.isInitial = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"Begining %d",[self.timer isValid]);
    if(self.presetTime.count !=0 && self.timer == nil){
        NSLog(@"Preset Timer here!");
        [self.startButton setTitle:@"Pause" forState:UIControlStateNormal];
        [self.timerPickerView setUserInteractionEnabled:NO];

        [self.timerPickerView selectRow:[self.presetTime[0] intValue] inComponent:0 animated:YES];
        [self.timerPickerView selectRow:[self.presetTime[1] intValue] inComponent:1 animated:YES];
        [self.timerPickerView selectRow:[self.presetTime[2] intValue] inComponent:2 animated:YES];
    }
    NSLog(@"Before second if statement timer is %d",[self.timer isValid]);
    if(self.timer == nil && !self.isInitial){
        NSLog(@"%d",[self.timer isValid]);
        NSLog(@"%d",self.isInitial);
        NSLog(@"Timer is not valid, so this is a new one!");
        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(animate) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
        
    }
}

- (void)setupHours {
    self.hours = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <= 12; i++) {
        NSString *s = [NSString stringWithFormat:@"%02d", i];
        [self.hours addObject:s];
    }
}

- (void)setupMinutes {
    self.minutes = [[NSMutableArray alloc] init];
    int j = 0;
    int i = 0;
    while(true){
        if(i == 60){
            i=0;
        }
        if(j==3600){
            break;
        }
        NSString *s = [NSString stringWithFormat:@"%02d", i];
        [self.minutes addObject:s];
        i++;
        j++;
    }
}

- (void)setupSeconds {
    self.seconds = [[NSMutableArray alloc] init];
    
    int j = 0;
    int i = 0;
    while(true){
        if(i == 60){
            i=0;
        }
        if(j==3600){
            break;
        }
        NSString *s = [NSString stringWithFormat:@"%02d", i];
        [self.seconds addObject:s];
        i++;
        j++;
    }
}


- (void)setupPickerViewNumbers {
    [self setupHours];
    [self setupMinutes];
    [self setupSeconds];
    
    self.pickerViewNumbers = [[NSMutableArray alloc] initWithObjects:self.hours,
                              self.minutes, self.seconds, nil];
}

- (IBAction)startButtonTapped:(UIButton *)sender {
    
    if(!self.isStarted) {
        for(int i=0;i<3;i++){
            if([self.timerPickerView selectedRowInComponent:i] != 00){
                NSLog(@"Started timer");
                self.isStarted = YES;
                [self.startButton setTitle:@"Pause" forState:UIControlStateNormal];
                [self.timerPickerView setUserInteractionEnabled:NO];
                self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(animate) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
                
                break;
            }
        }
    }else{
        NSLog(@"Paused timer");
        [self freeze];
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    }
}

-(void)freeze{
    self.isStarted = NO;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)animate {
    
    NSInteger hourIndex = [self.timerPickerView selectedRowInComponent:0];
    NSInteger minuteIndex = [self.timerPickerView selectedRowInComponent:1];
    NSInteger secondIndex = [self.timerPickerView selectedRowInComponent:2];
    
    if ( (hourIndex  == 00) && (minuteIndex % 60 == 00) && (secondIndex % 60 == 00) ) {
        [self.timer invalidate];
        self.timer = nil;
        
    }
    else{
         if(secondIndex % 60 == 00){
            
            self.row = secondIndex + 59;
            [self.timerPickerView selectRow:self.row inComponent:2 animated:YES];
            
            if (minuteIndex != 00) {
                self.row = minuteIndex -1;
                [self.timerPickerView selectRow:self.row inComponent:1 animated:YES];
                
            }else if (hourIndex != 00) {
                
                //hour
                self.row = hourIndex - 1;
                [self.timerPickerView selectRow:self.row inComponent:0 animated:YES];
                
                //minute
                if (minuteIndex % 60 == 00) {
                    self.row = minuteIndex + 59;
                    [self.timerPickerView selectRow:self.row inComponent:1 animated:YES];
                
                } else {
                    self.row = minuteIndex - 1;
                    [self.timerPickerView selectRow:self.row inComponent:1 animated:YES];
                }
                
                //second
                if (secondIndex % 60 == 00) {
                    self.row = secondIndex +59;
                    [self.timerPickerView selectRow:self.row inComponent:2 animated:YES];
                } else {
                    self.row = secondIndex - 1;
                    [self.timerPickerView selectRow:self.row inComponent:2 animated:YES];
                }
            }
        } else {
            self.row = secondIndex - 1;
            [self.timerPickerView selectRow:self.row inComponent:2 animated:YES];
        }
    }
}

- (void)reloadComponent:(NSInteger)component{
    [self.timerPickerView selectRow:self.row inComponent:self.component animated:YES];
}


- (IBAction)resetButtonTapped:(UIButton *)sender {
    self.timerName.text = @" ";
    if(![self.startButton.titleLabel.text isEqualToString:@"Start"]){
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    }
    [self.timerPickerView setUserInteractionEnabled:YES];
    self.startButton.enabled = YES;
    for(int i=0;i<3 ;i++){
        [self.timerPickerView selectRow:0 inComponent:i animated:YES];
    }
    [self.timer invalidate];
    self.timer = nil;
}

- (IBAction)presetButtonTapped:(id)sender {
    self.isInitial = NO;
    [self.timer invalidate];
    self.timer = nil;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *presetsNC = [storyboard  instantiateViewControllerWithIdentifier:@"presetsNavigationController"];
    NSArray *viewControllers = [presetsNC viewControllers];
    PresetsTableViewController *presetsViewController = viewControllers[0];
    [presetsViewController setDelegate:self];

    [self presentViewController:presetsNC animated:YES completion:nil];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.component = component;
    self.row = row;
}


#pragma mark - data source and delegate for PickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return [self.pickerViewNumbers count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerViewNumbers[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickerViewNumbers[component][row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *viewAsLabel = (UILabel *)view;
    
    if(!viewAsLabel) {
        viewAsLabel = [[UILabel alloc] init];
        [viewAsLabel setFont:[UIFont fontWithName:@"DigitalReadoutExpUpright" size:50]];
        [viewAsLabel setTextAlignment:NSTextAlignmentCenter];
        [viewAsLabel setBackgroundColor:[UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1]];
        [viewAsLabel setTextColor:[UIColor colorWithRed:255/255 green:62.0/255 blue:127.0/255 alpha:1.0]];
    }
    
    if (component == 0) {
        viewAsLabel.text = [self.hours objectAtIndex:row];
    } else if (component == 1) {
        viewAsLabel.text = [self.minutes objectAtIndex:row];
    } else {
        viewAsLabel.text = [self.seconds objectAtIndex:row];
    }
 
    return viewAsLabel;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 80;
}

#pragma mark - PresetsTableViewControllerDelegate implementation
- (void)presetTime:(NSArray *)presetTime withName:(NSString *)name {
    self.presetTime = presetTime;
    self.timerName.text = name;
    NSLog(@"Timer name: %@ and value: %@",self.timerName.text, self.presetTime);
}

@end
