//
//  TimerViewController.m
//  Time
//
//  Created by Diana Elezaj on 8/22/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()


@property (nonatomic) NSArray *_pickerData;
    

@property (nonatomic) NSInteger countDown;
@property (strong, nonatomic) IBOutlet UIButton *startStopButton;
@property (strong, nonatomic) IBOutlet UIButton *pauseResume;



@end

@implementation TimerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //initialize Data
    self._pickerData = @[@"Popcorn", @"Coffee", @"Reheat", @"Running", @"Defrost"];
    // Connect data
    self.picker.dataSource = self;
    self.picker.delegate = self;
}



//- (void) advanceTimer:(NSTimer *)timer{
//	
//}

- (IBAction)startStopButton:(id)sender {
    
//    NSTimer *countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(advanceTimer:) userInfo:nil repeats:YES];
//    
//    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
//    [runLoop addTimer: countDownTimer forMode:NSDefaultRunLoopMode];
//    {
//        self.countDown = 60;
//        
//    }


}
- (IBAction)pauseResumeButton:(id)sender {
}

 
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


 #pragma mark - PickerView
// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self._pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self._pickerData[row];
}

 

@end
