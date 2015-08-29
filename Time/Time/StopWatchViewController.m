//
//  StopWatchViewController.m
//  Time
//
//  Created by Jason Wang on 8/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "StopWatchViewController.h"


@interface StopWatchViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lapTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *lapButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

//Time
@property (nonatomic) NSDate *startDate;

@property (nonatomic) NSTimeInterval startTime;

@property (nonatomic) NSTimeInterval elapsed;

@property (nonatomic) NSTimeInterval timeAlreadyRunSecs;


//Lap Time
@property (nonatomic) NSDate *lapStartDate;

@property (nonatomic) NSTimeInterval lapStartTime;

@property (nonatomic) NSTimeInterval lapElapsed;

@property (nonatomic) NSTimeInterval lapAlareadyRunSecs;



@property (nonatomic) BOOL running;

@property (nonatomic) NSMutableArray *lapTimeMutableArray;

@end


@implementation StopWatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetTimeMode];
}

#pragma mark StateView
-(void)resetTimeMode{
    self.lapButton.enabled = NO;
    [self.lapButton setHidden:NO];
    [self.stopButton setHidden:YES];
    [self.resetButton setHidden:YES];
    self.timeLabel.text = @"00:00.00";
    self.lapTimeLabel.text = @"00:00.00";
    self.timeAlreadyRunSecs = 0.0;
    self.lapAlareadyRunSecs = 0.0;
    self.running = NO;
    self.lapTimeMutableArray = [[NSMutableArray alloc] init];
}

-(void)runningTimeMode{
    [self.startButton setHidden:YES];
    [self.stopButton setHidden:NO];
    self.lapButton.enabled = YES;
    [self.lapButton setHidden:NO];
    [self.resetButton setHidden:YES];
    self.running = YES;
}

-(void)pauseTimeMode{
    [self.startButton setHidden:NO];
    [self.stopButton setHidden:YES];
    [self.lapButton setHidden:YES];
    [self.resetButton setHidden:NO];
    self.running = NO;
}

#pragma mark IBActions
- (IBAction)startUIButton:(UIButton *)sender {
    self.startTime = [NSDate timeIntervalSinceReferenceDate];
    self.startDate = [[NSDate alloc] init];
    self.lapStartTime = [NSDate timeIntervalSinceReferenceDate];
    self.lapStartDate = [[NSDate alloc] init];
    [self runningTimeMode];
    [self updateTime];
}

- (IBAction)stopUIButton:(UIButton *)sender {
    self.timeAlreadyRunSecs += [[NSDate date]timeIntervalSinceDate:self.startDate];
    self.lapAlareadyRunSecs += [[NSDate date]timeIntervalSinceDate:self.lapStartDate];
    [self pauseTimeMode];
}

- (IBAction)lapUIButton:(UIButton *)sender {
    [self runningTimeMode];
    [self.lapTimeMutableArray insertObject:self.lapTimeLabel.text atIndex:0];
    self.lapTimeLabel.text = @"00:00.00";
    self.lapStartTime = [NSDate timeIntervalSinceReferenceDate];
    self.lapAlareadyRunSecs = 0.0;
    self.lapStartDate = [[NSDate alloc]init];
    [self updateTime];
    NSLog(@"%@", self.lapTimeMutableArray);
}



- (IBAction)resetUIButton:(UIButton *)sender {
    [self resetTimeMode];
}


#pragma mark TimeMethods


-(void)updateTime{
    if (self.running == NO) return;
    
    [self timeIncrement:self.startTime :self.timeAlreadyRunSecs];
    [self lapTimeIncrement:self.lapStartTime :self.lapAlareadyRunSecs];
    
    [self performSelector:@selector(updateTime) withObject:self afterDelay:0.01];
}

//TIME
-(void)timeIncrement: (NSTimeInterval)initTime : (NSTimeInterval)alreadyRunSecs {
    
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    
    self.elapsed = alreadyRunSecs + currentTime - initTime;
    
    int mins = (int) (self.elapsed / 60.0);
    self.elapsed -= mins * 60;
    int secs = (int) (self.elapsed);
    self.elapsed -= secs;
    int fraction = self.elapsed * 100.0;
    
    self.timeLabel.text = [self timeString:mins :secs :fraction];
}


//LAP TIME

-(void)lapTimeIncrement: (NSTimeInterval)initTime : (NSTimeInterval)alreadyRunSecs {
    
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    
    self.lapElapsed = alreadyRunSecs + currentTime - initTime;
    
    int mins = (int) (self.lapElapsed / 60.0);
    self.lapElapsed -= mins * 60;
    int secs = (int) (self.lapElapsed);
    self.lapElapsed -= secs;
    int fraction = self.lapElapsed * 100.0;
    
    self.lapTimeLabel.text = [self timeString:mins :secs :fraction];
}

-(NSString *)timeString: (int)mins : (int)second : (int)fraction {
    
    return [NSString stringWithFormat:@"%02u:%02u.%02u", mins, second, fraction];
}



#pragma mark TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lapTimeMutableArray.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *time = self.lapTimeMutableArray[indexPath.row];
    cell.textLabel.text = time;
    
    return cell;
    
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
