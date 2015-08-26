//
//  TimerViewController.m
//  Time
//
//  Created by Elber Carneiro on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *timerPickerView;
@property (nonatomic) NSMutableArray *hours;
@property (nonatomic) NSMutableArray *minutes;
@property (nonatomic) NSMutableArray *seconds;
@property (nonatomic) NSMutableArray *pickerViewNumbers;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

//For use with UIPickerView
@property (nonatomic) NSTimer *timer;
@property (nonatomic) CFTimeInterval initialTime;
@property (nonatomic) CFTimeInterval lapInitialTime;
@property (nonatomic) NSArray *presetTime;

@property (nonatomic) NSInteger component;
@property (nonatomic) NSInteger row;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPickerViewNumbers];
    
    self.timerPickerView.delegate = self;
    self.timerPickerView.dataSource = self;
    
    // self.timer2 = [CADisplayLink displayLinkWithTarget:self
    //                                           selector:@selector(refreshTimerLabel)];
    // [self.timer2 setPaused:YES];
    // [self.timer2 addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
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
    //self.startButton.enabled = NO;
    
    if([self.startButton.titleLabel.text isEqualToString:@"Start"]){
        
        
        
        for(int i=0;i<3;i++){
            if([self.timerPickerView selectedRowInComponent:i] != 00){
                [self.startButton setTitle:@"Pause" forState:UIControlStateNormal];
                [self.timerPickerView setUserInteractionEnabled:NO];
                self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(animate) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
                break;
            }
        }
        
        
    }else{
        [self freeze];
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    }
}

-(void)freeze{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)animate {
    
    NSInteger hourIndex = [self.timerPickerView selectedRowInComponent:0];
    NSInteger minuteIndex = [self.timerPickerView selectedRowInComponent:1];
    NSInteger secondIndex = [self.timerPickerView selectedRowInComponent:2];
    
    if ( (hourIndex  == 00) && (minuteIndex % 60 == 00) && (secondIndex % 60 == 00) ) {
        [self.timer invalidate];
    }
    else{
//        if( (hourIndex == 00) && (minuteIndex == 00) && (secondIndex == 00) ){
//            [self.timer invalidate];
//        }
         if(secondIndex % 60 == 00){
            
            self.row = secondIndex + 59;
            [self.timerPickerView selectRow:self.row inComponent:2 animated:YES];
            
            if (minuteIndex != 00) {
                self.row = minuteIndex -1;
                [self.timerPickerView selectRow:self.row inComponent:1 animated:YES];
                
            } else if (hourIndex != 00) {
                
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
    [self.timerPickerView setUserInteractionEnabled:YES];
    self.startButton.enabled = YES;
    [self.timerPickerView reloadAllComponents];
    for(int i=0;i<3 ;i++){
        [self.timerPickerView selectRow:0 inComponent:i animated:YES];
    }
    
    [self.timer invalidate];
}

- (IBAction)presetButtonTapped:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *presetsNC = [storyboard instantiateViewControllerWithIdentifier:@"presetsNavigationController"];
    NSArray *viewControllers = [presetsNC viewControllers];
    [viewControllers[0] setDelegate:self];
    
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

#pragma mark - PresetsTableViewControllerDelegate implementation
- (void)presetTime:(NSArray *)presetTime {
    self.presetTime = presetTime;
    NSLog(@"%@", self.presetTime);
}

@end
