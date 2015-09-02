//
//  PresetViewController.m
//  Time
//
//  Created by Diana Elezaj on 8/29/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "PresetViewController.h"
#import "Preset.h"
#import "PressetData.h"
#import <AVFoundation/AVFoundation.h>

@interface PresetViewController ()
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *resetButton;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *timerPickerView;
@property (nonatomic) NSArray *timerPickerArray;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSInteger seconds;

@property (nonatomic, strong) IBOutlet UILabel *progressLabel;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) NSTimer *progressTimer;

@property (nonatomic) int count;



@end

@implementation PresetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"presetBack"]];
    [self.navigationItem setTitle:@"Preset"];

    self.timeLabel.text = @"00:00:00";
    self.timerPickerArray = [PressetData sharedModel].allPresets;
    self.timerPickerView.dataSource = self;
    self.timerPickerView.delegate = self;
    [self.startButton setBackgroundImage:[UIImage imageNamed:@"1start"] forState:UIControlStateNormal];
    [self.resetButton setBackgroundImage:[UIImage imageNamed:@"1reset"] forState:UIControlStateNormal];
    [self.stopButton setBackgroundImage:[UIImage imageNamed:@"1stop"] forState:UIControlStateNormal];

    self.count = 0;
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self.timerPickerView reloadAllComponents];
    [self.timer invalidate];
   }

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *pickerLabel =   (UILabel *)view;
    
    if (pickerLabel == nil) {
        
        pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
    }
    
    [pickerLabel setText:[self.timerPickerArray objectAtIndex:row]];
    return pickerLabel;
}


- (IBAction)stopButtonTapped:(UIButton *)sender {
    [self.timer invalidate];
    [self.progressTimer invalidate];
 
}


- (IBAction)resetButtonTapped:(UIButton *)sender {
    [self updatePresetLabel];
    self.progressLabel.text = @"0 %";
    self.count = 0;


}

- (void)updateUI:(NSTimer *)timer
{
    static int count =0; count++;
    
    if (count <=self.seconds)
    {
        self.progressLabel.text = [NSString stringWithFormat:@"%ld %%",count*100/self.seconds];
        self.progressView.progress = (float)count/self.seconds;
    } else
    {
        [self.progressTimer invalidate];
        self.progressTimer = nil;
    }
}




- (IBAction)startButtonTapped:(UIButton *)sender {
   
    
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateUI:) userInfo:nil repeats:YES];

        [self updatePresetLabel];
        [self runTimer];
 }

-(void)convertTime: (NSString *)time{
    
    NSArray *timeConverted = [time componentsSeparatedByString:@":"];
    
    NSInteger hours = [timeConverted[0] integerValue];
    NSInteger minutes = [timeConverted[1] integerValue];
    NSInteger seconds = [timeConverted[2] integerValue];
    
    NSInteger totalTime = (hours * 3600) + (minutes * 60) + seconds;
    self.seconds = totalTime;
}
-(void)setPresetTimer:(Preset *)timer With: (UIPickerView *)pickerView{
    
    NSInteger selectedRow = [pickerView selectedRowInComponent:0];
    NSString *selection = [PressetData sharedModel].allPresets[selectedRow];
    NSArray *separatedComponents = [selection componentsSeparatedByString:@"     "];
    
    timer.presetTime = separatedComponents[1];
    self.timeLabel.text = timer.presetTime;
    timer.presetName = separatedComponents[0];
}

-(void)runTimer{
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

-(void)timerFired:(NSTimer *)timer{
    NSInteger hours, hours_rem, minutes, minutes_rem;
    self.seconds -= 1;
    
      hours = self.seconds / 3600;
      hours_rem = self.seconds % 3600;
    
      minutes =   hours_rem/60 ;
      minutes_rem = hours_rem % 60;
    
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hours, minutes, minutes_rem];
    
    if (hours <= 0 && minutes <= 0 && minutes_rem <= 0){
        [timer invalidate];
    }
}

- (void)updatePresetLabel{
    {
        
        [self setPresetTimer:[PressetData sharedModel].presetModel With:self.timerPickerView];
        
        self. timeLabel.text = [PressetData sharedModel].presetModel.presetTime;
        
        [self convertTime:[PressetData sharedModel].presetModel.presetTime];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.timerPickerArray.count;
}


- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return self.timerPickerArray[row];
}

@end
