//
//  StopwatchVC.m
//  StopWatch
//
//  Created by Natalia Estrella on 8/23/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import "StopwatchVC.h"


@interface StopwatchVC () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;
@property (weak, nonatomic) IBOutlet UIButton *lapResetButton;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic) NSMutableArray *laps;

//Alpha: Step 2
@property (nonatomic) NSTimeInterval maxLapTimeInterval;



@end

@implementation StopwatchVC

- (void)loadView {
    [super loadView];
    
    self.laps = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.timerLabel.text = [NSString stringWithFormat:@"00:00:00"];
    
    
    self.lapsTableView.dataSource = self;
    self.lapsTableView.delegate = self;
}

-(NSString *)formattedTime: (NSTimeInterval) timeInterval {
    int totalHundredths = timeInterval * 100;
    int hours = totalHundredths / 360000;
    int minutes = (totalHundredths - (hours * 360000)) / 6000;
    int seconds = (totalHundredths - (hours * 360000) - (minutes * 6000)) / 100;
    int milliseconds = totalHundredths - (hours * 360000) - (minutes * 6000) - (seconds * 100);
    
    
    //Potetial for creating a lap
    NSString *displayTime = [NSString stringWithFormat:@"%02d:%02d:%02d",minutes,seconds,milliseconds];
    return displayTime;
}

-(void) beginStopWatch {
    
    self.startTime = [[NSDate alloc] init];
    self.startLapTime = self.startTime;
    
    //set up timer
    self.timer = [NSTimer timerWithTimeInterval:1/60.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    //timer to the run loop
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
    
    [self.lapResetButton setTitle:@"Lap" forState:UIControlStateNormal];
}

- (IBAction)startStopTapped:(id)sender {

    if ([self.startStopButton.titleLabel.text isEqualToString:@"Start"]) {
        self.startStopButton.titleLabel.textColor = [UIColor colorWithRed:72 green:81 blue:71 alpha:0];
        [self beginStopWatch];
    }
    else {
        [self.timer invalidate];

//        //This is where you died
        self.totalTime = self.totalTime + self.totalSessionTime;
        
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        [self.lapResetButton setTitle:@"Reset" forState:UIControlStateNormal];
        
    }
    
}
- (IBAction)lapResetTapped:(id)sender {
    if ([self.lapResetButton.titleLabel.text isEqualToString:@"Lap"]) {
        self.lapResetButton.titleLabel.textColor = [UIColor blackColor];
        
        NSTimeInterval timeSinceLastLap = -[self.startLapTime timeIntervalSinceNow];

        //set self.startTimer to NOW
        self.startLapTime = [[NSDate alloc] init];
        
        //set up timer
//        self.lapTimer = [NSTimer timerWithTimeInterval:1/60.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        
        //timer to the run loop
//        [[NSRunLoop currentRunLoop] addTimer:self.lapTimer forMode:NSRunLoopCommonModes];
        
        //insert in the middle of the Array // addObject goes at the end of the array
        //adding the current time into lap
//Alpha: Step 3
        self.maxLapTimeInterval = MAX(self.maxLapTimeInterval, timeSinceLastLap);
        [self.laps addObject:@(timeSinceLastLap)];
        
        [self.lapsTableView reloadData];

    }
    else {
        
        //reset everything
        
        [self.lapResetButton.titleLabel.text isEqualToString:@"Reset"];
        
        [self.laps removeAllObjects];
        [self.timerLabel setText:@"00:00:00"];
        self.totalTime = 0;
        self.totalLapTime = 0;
        
        self.maxLapTimeInterval = 0;
    
        [self.lapsTableView reloadData];
    }
}

- (void)timerFired:(NSTimer *)timer {
 
    //get the current time
    NSDate *now = [[NSDate alloc] init];
    
    self.totalSessionTime = [now timeIntervalSinceDate:self.startTime];
    NSTimeInterval distance = self.totalTime + self.totalSessionTime;
    
    self.timerLabel.text = [NSString stringWithFormat:@"%@", [self formattedTime:distance]];
    NSLog(@"%f", distance);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.laps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    //you only have one section
    //double balue undoes the @() on a double nti
    NSNumber *lapDuration = self.laps[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Laps %@", [self formattedTime:[lapDuration doubleValue]]];
//    cell.detailTextLabel.text = self.laps[indexPath.row];
    
//Alpha: Step 4
    CGFloat alpha = 0;

//Alpha: Step 5: Becuase rockets have exploded because of this. 

    if (self.maxLapTimeInterval > 0) {
        alpha = lapDuration.doubleValue / self.maxLapTimeInterval;
    }
//Alpha: Step 1
    
    cell.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:alpha];
    cell.textLabel.backgroundColor = [UIColor clearColor];

    
    

    return cell;
}



@end
