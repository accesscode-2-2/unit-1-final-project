//
//  AnotherEventViewController.m
//  Time
//
//  Created by Lauren Caponong on 9/2/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "AnotherEventViewController.h"

@interface AnotherEventViewController ()

@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (strong, nonatomic)NSDate *destinationDay;
@property (strong, nonatomic)NSTimer *timer;



@end

@implementation AnotherEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
        self.destinationDay = [NSDate dateWithTimeIntervalSince1970:1456617600];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLabel)userInfo:nil repeats:YES];


}



- (IBAction)updateLabel{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    int units = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date] toDate: self.destinationDay options:0];
    
    self.countdownLabel.text = [NSString stringWithFormat:@"%ld%c:%ld%c:%ld%c:%ld%c", (long)[components day], 'd', (long)[components hour]+4, 'h', (long)[components minute], 'm', (long)[components second], 's'];
    
}



-(IBAction)startFade:(id)sender{
    
    [self.countdownLabel setAlpha:0.0f];
    
    //fade in
    [UIView animateWithDuration:2.0f animations:^{
        
        [self.countdownLabel setAlpha:1.0f];
        
    } completion:^(BOOL finished) {
        
        //fade out
        [UIView animateWithDuration:2.0f animations:^{
            
            [self.countdownLabel setAlpha:0.0f];
            
        } completion:nil];
        
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
