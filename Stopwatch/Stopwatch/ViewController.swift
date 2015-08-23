//
//  ViewController.swift
//  Stopwatch
//
//  Created by Jovanny Espinal on 8/21/15.
//  Copyright © 2015 Jovanny Espinal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    //MARK: Properties
    
    var timer = NSTimer()
    var lapTimer = NSTimer()
    
    var startTime : CFAbsoluteTime = 0
    var elapsedTime : NSTimeInterval = 0
    var stopwatchString: String = ""
    
    var lapStartTime : CFAbsoluteTime = 0
    var lapElapsedTime : NSTimeInterval = 0
    var lapString: String = ""
    
    var laps: [String] = []
    var isStopped: Bool = true
    var canAddLaps: Bool = false
    
    @IBOutlet weak var stopwatchLabel: UILabel!
    @IBOutlet weak var lapsTableView: UITableView!
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var lapsResetButton: UIButton!
    
    //MARK: Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //the stopwatchLabel is set to 00:00.00
        stopwatchLabel.text = "00:00.00"
    }
    
    //MARK: Actions
    
    @IBAction func startStop(sender: AnyObject) {
        
        if isStopped == true { //start stopwatch
            
            //record start time
            startTime = CFAbsoluteTimeGetCurrent()
            lapStartTime = CFAbsoluteTimeGetCurrent()
            
            //isStopped is false when the stopwatch is started
            isStopped = false
            
            //Allow for laps to be added to the tableView (refer to the lapsReset method)
            canAddLaps = true
            
            //updateStopwatch method is called every 0.01 seconds
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: ("updateStopwatch"), userInfo: nil, repeats: true)
            lapTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: ("updateStopwatch"), userInfo: nil, repeats: true)
            
            //Update buttons
            startStopButton.setImage(UIImage(named: "stop.png"), forState: UIControlState.Normal)
            lapsResetButton.setImage(UIImage(named: "lap.png"), forState: UIControlState.Normal)
        }
        
        else { //stop stopwatch
            
            //isStopped is true when the stopwatch is stopped
            isStopped = true
            
            //prevent laps from being added to tableView (refer to the lapsReset method)
            canAddLaps = false
            
            //invalidate the timers when the stopwatch is stopped
            timer.invalidate()
            lapTimer.invalidate()
            
            //update buttons
            startStopButton.setImage(UIImage(named: "start.png"), forState: .Normal)
            lapsResetButton.setImage(UIImage(named: "reset.png"), forState: .Normal)
        }
        
    }
    
    @IBAction func lapsReset(sender: AnyObject) {
        
        if canAddLaps == true { //add lap
            
            lapStartTime = CFAbsoluteTimeGetCurrent()
            //add the time since the last lap to the laps array (refer to the updateStopWatch method)
            laps.insert(lapString, atIndex: 0)
            
            //Reset the lap counter and lap string
            lapElapsedTime = 0
            lapString = "00:00.00"
            
            //Refreshes the table view that contains the lap tim
            lapsTableView.reloadData()
        }
            
        else { //reset
            
            //remove all elements in the laps array
            laps.removeAll(keepCapacity: false)
            
            //Refreshes the table view that contains the lap times
            lapsTableView.reloadData()
            
            //change reset button to lap button
            lapsResetButton.setImage(UIImage(named: "lap.png"), forState: .Normal)
            
            // Reverts all time variables to 0
            elapsedTime = 0
            lapElapsedTime = 0
            
            lapString = "00:00.00"
            
            //reset the stopwatchString (just the string) back to 0.
            stopwatchString = "00:00.00"
            stopwatchLabel.text = stopwatchString
        }
    }
    
    //MARK: Update method
    func updateStopwatch() {
        
        elapsedTime = CFAbsoluteTimeGetCurrent() - startTime
        print("elapsed time: \(elapsedTime)")
        
        lapElapsedTime = CFAbsoluteTimeGetCurrent() - lapStartTime
        
        print("lap time: \(lapElapsedTime)")
        
        stopwatchString = stringFromTimeInterval(elapsedTime)
        stopwatchLabel.text = stopwatchString
        
        lapString = stringFromTimeInterval(lapElapsedTime)
        
    }
    
    func stringFromTimeInterval(interval: CFTimeInterval) -> String {
        let intInterval = Int(interval)
        let minutes = (intInterval / 60) % 60
        let seconds = intInterval % 60
        let milliseconds = interval - floor(interval)
        if floor(milliseconds * 100) <= 9{
            print(String(format: "%02d:%02d:0%d", minutes, seconds, floor(milliseconds * 100)))
            return String(format: "%02d:%02d:00", minutes, seconds, milliseconds)
        }
        print(String(format: "%02d:%02d:%.f", minutes, seconds, milliseconds * 100))
        return String(format: "%02d:%02d:%.f", minutes, seconds, milliseconds * 100)
    }
    
    // MARK: TableView methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel!.text = "Lap \(laps.count - indexPath.row)"
        cell.detailTextLabel?.text = laps[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
}


