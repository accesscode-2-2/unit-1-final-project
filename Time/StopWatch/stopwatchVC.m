//
//  stopwatchVC.m
//  StopWatch
//
//  Created by MacMan on 8/26/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import "stopwatchVC.h"

@interface stopwatchVC ()


@property NSString *displayTime;


@end


@implementation stopwatchVC

@synthesize lapTableView = _lapTableView;
@synthesize laps = _laps;

-(NSTimer *) createTimer {
    
    return [NSTimer scheduledTimerWithTimeInterval:1.0/5000 target:self selector:@selector(timerCount) userInfo:nil repeats:YES];
}

-(void)timerCount{
    
    //count out miliseconds
    countNumber0 = countNumber0 +1;
    _timerDisplay0.text = [NSString stringWithFormat:@"%i",countNumber0];
    
    //if miliseconds == 100 reset milisecond count and start counting seconds
    if (countNumber0 == 10) {
        countNumber1 = countNumber1 +1 ;
        _timerDisplay1.text = [NSString stringWithFormat:@"%i",countNumber1];
        
        countNumber0 = 0;
    }
        //if seconds == 60 reset seconds counter and start counting minutes
        if (countNumber1 ==60){
            
            countNumber2 = countNumber2 + 1;
            _timerDisplay2.text = [NSString stringWithFormat:@"%i",countNumber2];
            countNumber1 = 0;
        }
        _displayTime = [NSString stringWithFormat:@"%02d:%02d:%02d",countNumber2,countNumber1,countNumber0];
    }



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.laps = [[NSMutableArray alloc] init];
 }


#pragma mark - Table view data source


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//set number of rows
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.laps count];
}
//create a cell and fill it with info

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *SimpleIdentifier = @"SimpleIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier];
    if (cell ==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleIdentifier];
    }
    cell.textLabel.text = self.laps[indexPath.row];
    return cell;
}

/*
#pragma mark - Navigation

 In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     Get the new view controller using [segue destinationViewController].
     Pass the selected object to the new view controller.
}
*/



- (IBAction)startStopButtonAction:(id)sender {
    
    
    if (!_KNTimer){

            //create timer object that fires off every 0.01th of a second
        _KNTimer = [self createTimer];
        
        UIImage *startStopImage = [UIImage imageNamed:@"fe_runningStop.png"];
        [_startStopButton setImage:startStopImage forState:UIControlStateNormal];
        
        UIImage *lapResetImage = [UIImage imageNamed:@"fe_runningLap.png"];
        [_lapResetButton setImage:lapResetImage forState:UIControlStateNormal];
        
        
        
    } else {
        
        [_KNTimer invalidate];
        
        UIImage *startImageGreen = [UIImage imageNamed:@"fe_runningStart.png"];
        [_startStopButton setImage:startImageGreen  forState:UIControlStateNormal];
        
        UIImage *stopImageRed  = [UIImage imageNamed:@"fe_runningStop.png"];
        [_startStopButton setImage:stopImageRed forState:UIControlStateNormal];
       
        
        UIImage *restartImageGreen = [UIImage imageNamed:@"fe_runningStart.png"];
        [_startStopButton  setImage:restartImageGreen forState:UIControlStateNormal];
        
        
        UIImage *resetImageBlue = [UIImage imageNamed:@"fe_runningReset.png"];
        [_lapResetButton setImage:resetImageBlue forState:UIControlStateNormal];
    }
    
    
}


- (IBAction)lapResetButtonAction:(id)sender {
    
    if(_KNTimer){
        
        UIImage *lapReStartImage2 = [UIImage imageNamed:@"fe_runningLap.png"];
        [_lapResetButton setImage:lapReStartImage2 forState:UIControlStateNormal];
        
        
            [self.laps addObject:_displayTime];
            [self.lapTableView reloadData];
        
        return   NSLog(@"%@",_displayTime);
       
    }
    
    
    if(!_KNTimer){
        
        [_KNTimer invalidate];
         self.laps = [[NSMutableArray alloc] init];
        [self.lapTableView reloadData];
        countNumber2 = 0;
        countNumber1 = 0;
        countNumber0 = 0;

        _timerDisplay0.text = [NSString stringWithFormat :@"00"];
        _timerDisplay1.text = [NSString stringWithFormat :@"00"];
        _timerDisplay2.text = [NSString stringWithFormat :@"00"];
           }
}



@end



























