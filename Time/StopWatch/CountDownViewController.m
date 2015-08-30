//
//  CountDownViewController.m
//  StopWatch
//
//  Created by Krishna Picart on 8/29/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import "CountDownViewController.h"
//#import "stopwatchVC.h"

@interface CountDownViewController()
@property NSString *displayTime;


@end


@implementation CountDownViewController

@synthesize countDownArray;




-(NSTimer *) createCountDownTimer {
    
    return [NSTimer scheduledTimerWithTimeInterval:1.0/10 target:self selector:@selector(countDownTimerCount) userInfo:nil repeats:YES];
}


-(void)countDownTimerCount{
    
    //count out miliseconds
    countDownNumber0 = countDownNumber0 ;
    _countDownDisplayLabel0.text = [NSString stringWithFormat:@"%i",countDownNumber0];
    
    //if miliseconds == 100 reset milisecond count and start counting seconds
    if (countDownNumber0 > 0 ) {
        countDownNumber0 = countDownNumber0-1;
        _countDownDisplayLabel1.text = [NSString stringWithFormat:@"%i",countDownNumber1];
    
        countDownNumber0 = 100;
    }
    
    
    
    //if seconds == 60 reset seconds counter and start counting minutes
    if (countDownNumber1 > 0){
        
        countDownNumber2 = countDownNumber2 - 1;
        _countDownDisplayLabel2.text = [NSString stringWithFormat:@"%i",countDownNumber2];
        countDownNumber1 = 0;

    }
    
    
    
    _displayTime = [NSString stringWithFormat:@"%02d:%02d:%02d",countDownNumber2,countDownNumber1,countDownNumber0];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.countDownArray = [[NSMutableArray alloc] init];
}



#pragma mark - Table view data source


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//set number of rows
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.countDownArray count];
}
//create a cell and fill it with info

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *SimpleIdentifier = @"SimpleIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier];
    if (cell ==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleIdentifier];
    }
    cell.textLabel.text = self.countDownArray[indexPath.row];
    return cell;
}



- (IBAction)countDownStartButtonAction:(id)sender {
    
    
        if (!_countDownTimer){
    
            //create timer object that fires off every 0.01th of a second
            _countDownTimer = [self createCountDownTimer];
    
            UIImage *startStopImage = [UIImage imageNamed:@"fe_runningStop.png"];
            [_countDownStartButton setImage:startStopImage forState:UIControlStateNormal];
    
          //  UIImage *lapResetImage = [UIImage imageNamed:@"fe_runningLap.png"];
           // [_countDownResetButton setImage:lapResetImage forState:UIControlStateNormal];
    
    
    
        } else {
    
            [_countDownTimer invalidate];
    
            UIImage *startImageGreen = [UIImage imageNamed:@"fe_runningStart.png"];
            [_countDownStartButton setImage:startImageGreen  forState:UIControlStateNormal];
    
            UIImage *stopImageRed  = [UIImage imageNamed:@"fe_runningStop.png"];
            [_countDownStartButton setImage:stopImageRed forState:UIControlStateNormal];
    
    
            UIImage *restartImageGreen = [UIImage imageNamed:@"fe_runningStart.png"];
            [_countDownStartButton  setImage:restartImageGreen forState:UIControlStateNormal];
    
    
            UIImage *resetImageBlue = [UIImage imageNamed:@"fe_runningReset.png"];
            [_countDownResetButton setImage:resetImageBlue forState:UIControlStateNormal];
        }
        
        
    }
    

    



- (IBAction)countDownResetButtonAction:(id)sender {
    
        [_countDownTimer invalidate];
        self.countDownArray = [[NSMutableArray alloc] init];
        [self.countDownTableView reloadData];
        countDownNumber2 = 99;
        countDownNumber1 = 99;
        countDownNumber0 = 99;
        
        _countDownDisplayLabel0.text = [NSString stringWithFormat :@"00"];
        _countDownDisplayLabel1.text = [NSString stringWithFormat :@"00"];
        _countDownDisplayLabel2.text = [NSString stringWithFormat :@"00"];
    }


//- (IBAction)countDownStopButtonAction:(id)sender {
//}




@end


















///*
// #pragma mark - Navigation
// 
// In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.
// }
// */
//
//
//
//- (IBAction)startButtonAction:(id)sender {
//    
//    
//
//- (IBAction)lapResetButtonAction:(id)sender {
//    
//    if(_countDownTimer){
//        
//        UIImage *lapReStartImage2 = [UIImage imageNamed:@"fe_runningLap.png"];
//        [_lapResetButton setImage:lapReStartImage2 forState:UIControlStateNormal];
//        
//        
//        [self.laps addObject:_displayTime];
//        [self.lapTableView reloadData];
//        
//        return   NSLog(@"%@",_displayTime);
//        
//    }
//    
//    
//    if(!_KNTimer){
//        
//        [_KNTimer invalidate];
//        self.laps = [[NSMutableArray alloc] init];
//        [self.lapTableView reloadData];
//        countUpNumber2 = 0;
//        countUpNumber1 = 0;
//        countUpNumber0 = 0;
//        
//        _timerDisplay0.text = [NSString stringWithFormat :@"00"];
//        _timerDisplay1.text = [NSString stringWithFormat :@"00"];
//        _timerDisplay2.text = [NSString stringWithFormat :@"00"];
//    }
//}
//
//
//
//@end
//
//
//
//
