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
@property (nonatomic) CADisplayLink *timer;
@property (nonatomic) CFTimeInterval initialTime;
@property (nonatomic) CFTimeInterval lapInitialTime;
@property (nonatomic) CGFloat countdownTime;

@property (nonatomic) NSInteger component;
@property (nonatomic) NSInteger row;


@end

@implementation TimerViewController

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
- (IBAction)startButtonTapped:(UIButton *)sender {
   [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reloadComponent:) userInfo:nil repeats:NO];
    
}

- (void)reloadComponent:(NSInteger)component{
    
}


- (IBAction)resetButtonTapped:(UIButton *)sender {
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.component = component;
    self.row = row;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPickerViewNumbers];
    
    self.timerPickerView.delegate = self;
    self.timerPickerView.dataSource = self;
    
    self.timer  = [CADisplayLink displayLinkWithTarget:self
                                                       selector:@selector(refreshTimerLabel)];
    [self.timer setPaused:YES];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
-(void)presetTime:(CGFloat)presetTime {
    self.countdownTime = presetTime;
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
