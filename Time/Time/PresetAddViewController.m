//
//  PresetAddViewController.m
//  Time
//
//  Created by Diana Elezaj on 8/31/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "PresetAddViewController.h"
#import "PressetData.h"

@interface PresetAddViewController ()
@property (nonatomic) NSArray *pickerData;
@property (nonatomic) NSArray *pickerHours;
@property (nonatomic) NSArray *pickerMins;
@property (nonatomic) NSArray *pickerSecs;
@property (nonatomic) NSString *userPresetTimer;

@property (weak, nonatomic) IBOutlet UITextField *userInputTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *setTimerPickerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *hrsMinsSecsLabels;





@end

@implementation PresetAddViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//     self.userInputTextField.font = [UIFont fontWithName:@"PrintBold" size:18.0];
//    
//    [self setupLabelUI];
//    
//    self.userInputTextField.text = @"";
//    
//    self.pickerHours = [self setDigitsForPickerColumnArrays];
//    self.pickerMins = [self setDigitsForPickerColumnArrays];
//    self.pickerSecs = [self setDigitsForPickerColumnArrays];
//    
//    self.pickerData = @[self.pickerHours,
//                        self.pickerMins,
//                        self.pickerSecs
//                        ];
//    
//    self.setTimerPickerView.dataSource = self;
//    self.setTimerPickerView.delegate = self;
}

//- (void)setupLabelUI {
//    NSArray *labels = self.hrsMinsSecsLabels;
//    
//    for (UILabel *label in labels) {
//        label.font = [UIFont fontWithName:@"PrintBold" size:22.0];
//         label.layer.borderWidth = 1.5;
//         //label.layer.backgroundColor = [PresetTimerData sharedModel].chartreuse.CGColor;
//        label.layer.cornerRadius = 5.0;
//    }
//}
//
//-(NSMutableArray *)setDigitsForPickerColumnArrays {
//    
//    NSMutableArray *digits = @[@"00"].mutableCopy;
//    
//    NSInteger integer = 0;
//    
//    for (int i = 0; i < 99; i++) {
//        
//        integer += 1;
//        
//        NSString *digit = [NSString stringWithFormat:@"%ld", integer];
//        
//        if ([digit integerValue] < 10) {
//            
//            NSString *zero = @"0";
//            
//            digit = [zero stringByAppendingString:digit];
//        };
//        
//        [digits addObject:digit];
//        
//    }
//    
//    return digits;
//    
//}
//
//
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
//    
//    return 3;
//}
//
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
//    
//    return [self.pickerData[component] count];
//}
//
//- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    
//    return self.pickerData[component][row];
//}
//
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    
//    
//    UILabel *pickerLabel = (UILabel *)view;
//    
//    if (pickerLabel == nil) {
//        
//        pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
//        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
//        [pickerLabel setBackgroundColor:[UIColor clearColor]];
//        
//        [pickerLabel setFont:[UIFont fontWithName:@"DigitaldreamFat" size:22.0]];
//        
//        
//    }
//    //picker view array is the datasource
//    
//    [pickerLabel setText:[self.pickerHours objectAtIndex:row]];
//    [pickerLabel setText:[self.pickerMins objectAtIndex:row]];
//    [pickerLabel setText:[self.pickerSecs objectAtIndex: row]];
//    
//    return pickerLabel;
//    
//}
//
//-(void)setTimer:(Preset *)timer With:(UIPickerView *)pickerView{
//    
//    NSString *hour = [self.pickerHours objectAtIndex:[pickerView selectedRowInComponent:0]];
//    NSString *min = [self.pickerMins objectAtIndex:[pickerView selectedRowInComponent:1]];
//    NSString *sec = [self.pickerSecs objectAtIndex:[pickerView selectedRowInComponent:2]];
//    NSString *hourMinSec = [hour stringByAppendingFormat:@":%@:%@", min, sec];
//    
//    timer.presetTime = hourMinSec;
//    
//}
//
//
//- (IBAction)cancelButtonTapped:(UIBarButtonItem *)sender {
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//}
//
//
//- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender {
//    
//    if ([self.userInputTextField.text isEqualToString:@""]) {
//        
//        [PressetData sharedModel].presetModel.presetName = Nil;
//        [PressetData sharedModel].presetModel.presetTime  = Nil;
//        
//        NSLog(@"Preset Timer: %@", [PressetData sharedModel].presetModel.presetTime);
//        
//        [self setTimer:[PressetData sharedModel].inputPreset With:self.setTimerPickerView];
//        
//        NSLog(@"Unsaved Timer: %@", [PressetData sharedModel].inputPreset.presetTime);
//        
//        [self dismissViewControllerAnimated:YES completion:nil];
//        
//    }else {
//        
//        [PressetData sharedModel].all.presetName = self.userInputTextField.text;
//        
//        NSLog(@"timer name: %@",[PressetData sharedModel].presetModel.presetName);
//        
//        [self setTimer:[PressetData sharedModel].inputPreset With:self.setTimerPickerView];
//        
//        [PressetData sharedModel].inputPreset.presetTime = Nil;
//        NSLog(@"Unsaved Timer: %@", [PressetData sharedModel].inputPreset.presetTime);
//        
//        NSString *time = [PressetData sharedModel].presetModel.presetTime;
//        NSString *timerName = [PressetData sharedModel].presetModel.presetName;
//        
//        self.userPresetTimer = [timerName stringByAppendingFormat:@"     %@", time];
//        NSLog(@"user preset timer: %@", self.userPresetTimer);
//        
//        [[PressetData sharedModel].presetModel insertObject:self.allPresets atIndex:00];
//        NSLog(@"user preset timers: %@", [PressetData sharedModel].userPresetTimers);
//        
//        [PressetData sharedModel].inputPreset.time = Nil;
//        NSLog(@"unsaved time: %@", [PressetData sharedModel].inputPreset.time);
//        
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
