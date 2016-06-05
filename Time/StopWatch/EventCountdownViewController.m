//
//  EventCountdownViewController.m
//  StopWatch
//
//  Created by Natalia Estrella on 8/29/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import "EventCountdownViewController.h"

@interface EventCountdownViewController ()

@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *emojiImage;

@end

@implementation EventCountdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = [self.event name];
    self.emojiImage.image = [UIImage imageNamed:[self.event pictureName]];
    
    
    
    // create a new instance of NSTimer
    // equivalent of running [self timerFired] every 1.0 seconds
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    // make sure we add the new timer to the run loop so that it
    // executes
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)timerFired:(NSTimer *)timer {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSCalendarUnit unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
   
    NSDate *fromDate = [NSDate date];
    NSDate *toDate = self.event.endTime;
    
    NSDateComponents *components = [calendar components:unitFlag
                                               fromDate:[NSDate date]
                                                 toDate:self.event.endTime
                                                options:0];
    
    self.countdownLabel.text = [NSString stringWithFormat:@"Years:%@ Months:%@ Days:%@\nHours:%@ Minuets:%@ Seconds:%@ ", @(components.year), @(components.month), @(components.day), @(components.hour), @(components.minute), @(components.second)];
    
//    if ([fromDate timeIntervalSinceDate:toDate] ) {
//        
//    }
//
    
    if ([fromDate earlierDate:toDate] == toDate ) {
        [timer invalidate];
        self.countdownLabel.text = @"You're all set";
        
    }
}

@end
