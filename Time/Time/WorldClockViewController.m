//
//  WorldClockViewController.m
//  Time
//
//  Created by Chris David on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "WorldClockViewController.h"

@interface WorldClockViewController ()
@property (nonatomic) NSTimer *timer;
@end

@implementation WorldClockViewController


- (void)viewDidLoad {
    [super viewDidLoad];
 self.worldClockLabel.text = @"00.00.00";
 self.running = FALSE;
 self.startDate = [NSDate date];
self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(worldClockTimer:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)worldClockTimer: (NSTimer *) timer{
    
        NSDate *now = [NSDate date];
        
        static NSDateFormatter *dateFormatter;
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"h:mm:ss a";
        }
        self.worldClockLabel.text = [dateFormatter stringFromDate:now];
   
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
