//
//  ViewController.swift
//  Stopwatch
//
//  Created by Jovanny Espinal on 8/21/15.
//  Copyright © 2015 Jovanny Espinal. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    //MARK: Properties
    
    var timer: CADisplayLink!
    var lapTimer: CADisplayLink!
    
    var startTime : CFAbsoluteTime = 0
    var elapsedTime : CFAbsoluteTime = 0
    var stopwatchString: String = ""
    
    var lapStartTime : CFAbsoluteTime = 0
    var lapElapsedTime : CFAbsoluteTime = 0
    var lapString: String = ""
    
    var laps: [String] = []
    var isStopped: Bool = true
    var canAddLaps: Bool = false
    
    var totalTime : CFAbsoluteTime = 0
    
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
            
            //updateStopwatch method
            timer = CADisplayLink(target: self, selector: "updateStopwatch")
            lapTimer = CADisplayLink(target: self, selector: "updateLap")
            
            //Add to run loop
            timer.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
            lapTimer.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
            
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
            
            print("total time: \(totalTime)")
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
            
            lapString = "00:00.00"
            lapElapsedTime = 0
            
            totalTime = 0
            
            //reset the stopwatchString (just the string) back to 0.
            stopwatchString = "00:00.00"
            stopwatchLabel.text = stopwatchString
        }
    }
    
    //MARK: Update methods
    func updateStopwatch() {
        totalTime += timer.duration
        stopwatchString = stringFromTimeInterval(totalTime)
        
        stopwatchLabel.text = stopwatchString
        
    }
    
    func updateLap(){
        lapElapsedTime += lapTimer.duration
        lapString = stringFromTimeInterval(lapElapsedTime)
    }
    
    func stringFromTimeInterval(interval: CFTimeInterval) -> String {
        let intInterval = Int(interval)
        let minutes = (intInterval / 60) % 60
        let seconds = intInterval % 60
        let milliseconds = Int(floor(((interval - floor(interval)) * 100)))
        
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let millisecondsString = milliseconds > 9 ? "\(milliseconds)" : "0\(milliseconds)"
        
        let timeString = minutesString + ":" + secondsString + "." + millisecondsString
        
        return timeString
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


