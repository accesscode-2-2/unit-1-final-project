//
//  PresetEventCountdownViewController.m
//  Time
//
//  Created by Shena Yoshida on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "PresetEventCountdownViewController.h"
#import "BokehScene.h"

@interface PresetEventCountdownViewController ()

@property (weak, nonatomic) IBOutlet SKView *particleBackground;

@property (strong, nonatomic) NSDate *destinationDate1;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel1;
@property (strong, nonatomic) NSDate *destinationDate2;
@property (strong, nonatomic) NSDate *destinationDate3;
@property (strong, nonatomic) NSTimer *timer;

// continue adding preset dates to scroll view
// ideas: national cheese pizza day (sept 5), world nutella day (feb 5)

@end

@implementation PresetEventCountdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES]; // hide navigation bar that pops up automatically w swipe recognizer
    
    BokehScene * scene = [BokehScene sceneWithSize:_particleBackground.bounds.size]; // add spritekit animated images to background!
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [self.particleBackground presentScene:scene];
    
    self.destinationDate1 = [NSDate dateWithTimeIntervalSince1970:1446508801]; // epoch time conversion for Nov 3, 2015, National Sandwich Day
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateLabel {
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    int units = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date] toDate: self.destinationDate1 options:0];
   
    self.countdownLabel1.text = [NSString stringWithFormat:@"%ld%c:%ld%c:%ld%c:%ld%c", (long)[components day], 'd', (long)[components hour]+4, 'h', (long)[components minute], 'm', (long)[components second], 's'];
}


- (IBAction)swipeBack:(UISwipeGestureRecognizer *)sender {
    [self.navigationController popViewControllerAnimated:YES];
  
  //  [self.particleBackground presentScene:nil]; // end spritekit when moving back
}

@end
