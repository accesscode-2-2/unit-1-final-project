//
//  stopwatchVC.m
//  StopWatch
//
//  Created by MacMan on 8/26/15.
//  Copyright (c) 2015 MacManApp. All rights reserved.
//

#import "stopwatchVC.h"
#import "LapNotesTVC.h"
@interface stopwatchVC ()


@property NSString *displayTime;


@end


@implementation stopwatchVC

@synthesize lapTableView = _lapTableView;
@synthesize laps = _laps;

-(NSTimer *) createTimer {
    
    return [NSTimer scheduledTimerWithTimeInterval:1.0/100 target:self selector:@selector(timerCount) userInfo:nil repeats:YES];
}


-(void)timerCount{
    
    //count out miliseconds
    countUpNumber0 = countUpNumber0 +1;
    _timerDisplay0.text = [NSString stringWithFormat:@"%i",countUpNumber0];
    
    //if miliseconds == 100 reset milisecond count and start counting seconds
    if (countUpNumber0 == 100)
    
    {
        countUpNumber1 = countUpNumber1 +1 ;
        _timerDisplay1.text = [NSString stringWithFormat:@"%i",countUpNumber1];
        
        countUpNumber0 = 0;
    }
        //if seconds == 60 reset seconds counter and start counting minutes
        if (countUpNumber1 ==60)
        
        {
            countUpNumber2 = countUpNumber2 + 1;
            _timerDisplay2.text = [NSString stringWithFormat:@"%i",countUpNumber2];
            countUpNumber1 = 0;
        }
        _displayTime = [NSString stringWithFormat:@"%02d:%02d:%02d",countUpNumber2,countUpNumber1,countUpNumber0];
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.laps = [[NSMutableArray alloc] init];
 }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"startStopSegue2Notes" sender:self];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Make sure your segue name in storyboard is the same as this line
//    if ([[segue identifier] isEqualToString:@"startStopSegue2Notes"])
//    {
//        
//
//    }
//}


//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if([segue.identifier isEqualToString:@"startStopSegue2Notes"]){
//        LapNotesTVC *controller = (LapNotesTVC *)segue.destinationViewController;
//        controller.dataPassing = YES;
//    }
//}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showDetailSegue"]){
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        LapNotesTVC *controller = (LapNotesTVC *)navController.topViewController;
        controller.dataPassing = YES;
    }
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
    NSString *SimpleIdentifier = @"tytyty";
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

            //create timer object that fires off every 0.001th of a second
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
//        
//        UIImage *lapReStartImage2 = [UIImage imageNamed:@"fe_runningLap.png"];
//        [_lapResetButton setImage:lapReStartImage2 forState:UIControlStateNormal];
        
        
            [self.laps addObject:_displayTime];
        
            [self.lapTableView reloadData];
        
        return   NSLog(@"%@",_displayTime);
       
    }
//
//    
    if(!_KNTimer){
        
        [_KNTimer invalidate];
        //reset laps to empty array
        self.laps = [NSMutableArray array];
        
        //remove data on screen (refresh
        [self.lapTableView reloadData];
////        countUpNumber2 = 0;
////        countUpNumber1 = 0;
////        countUpNumber0 = 0;
        
        
        
        //display 0's after reset
        _timerDisplay0.text = [NSString stringWithFormat :@"00"];
        _timerDisplay1.text = [NSString stringWithFormat :@"00"];
        _timerDisplay2.text = [NSString stringWithFormat :@"00"];
           }
}
//


@end


