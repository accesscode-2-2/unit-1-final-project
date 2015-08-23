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
    
    for (int i = 0; i < 60; i++) {
        NSString *s = [NSString stringWithFormat:@"%02d", i];
        [self.minutes addObject:s];
    }
}

- (void)setupSeconds {
    self.seconds = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 60; i++) {
        NSString *s = [NSString stringWithFormat:@"%02d", i];
        [self.seconds addObject:s];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
