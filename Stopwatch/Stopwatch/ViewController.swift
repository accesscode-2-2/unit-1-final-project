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
    
    var minutes: Int = 0
    var seconds: Int = 0
    var fractions: Int = 0
    
    var lapMinutes: Int = 0
    var lapSeconds: Int = 0
    var lapFractions: Int = 0
    
    var minutesString: String = ""
    var secondsString: String = ""
    var fractionsString: String = ""
    var stopwatchString: String = ""
    
    var lapMinutesString: String = ""
    var lapSecondsString: String = ""
    var lapFractionsString: String = ""
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
            
            //add the time since the last lap to the laps array (refer to the updateStopWatch method)
            laps.insert(lapString, atIndex: 0)
            
            //Reset the lap counter
            lapMinutes = 0
            lapSeconds = 0
            lapFractions = 0
            
            lapString = "00:00.00"
            
            //Refreshes the table view that contains the lap times
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
            fractions = 0
            seconds = 0
            minutes = 0
            
            lapFractions = 0
            lapSeconds = 0
            lapMinutes = 0
            
            lapString = "00:00.00"
            
            //reset the stopwatchString (just the string) back to 0.
            stopwatchString = "00:00.00"
            stopwatchLabel.text = stopwatchString
            
        }
        
    }
    
    //MARK: Update method
    func updateStopwatch() {
        
        // Increments the fractions of a second by 1
        fractions += 1
        lapFractions += 1
        
        // If the fractions of a second reaches 100, seconds is incremented by 1
        if fractions == 100{

            seconds += 1
            fractions = 0
        }
        
        // If the second reaches 60, minute is incremented by 1 and sets seconds to 0
        if seconds == 60 {
            
            minutes += 1
            seconds = 0
        }
        
        // If the lapFractions of the a second reaches 100, seconds is incremented by 1
        if lapFractions == 100{
            
            lapSeconds += 1
            lapFractions = 0
        }
        
        // If the lapSeconds reaches 60, minute is incremented by 1 and sets seconds to 0
        if lapSeconds == 60 {
            
            lapMinutes += 1
            lapSeconds = 0
        }
        
        // Sets the strings for fractions, seconds, and minutes. If any number is greater than 9, display a 0 before it.
        // The ternary operations are a shorthand form of writing if/else statements. Condition ? Result if true : Result if false
        fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        lapFractionsString = lapFractions > 9 ? "\(lapFractions)" : "0\(lapFractions)"
        lapSecondsString = lapSeconds > 9 ? "\(lapSeconds)" : "0\(lapSeconds)"
        lapMinutesString = lapMinutes > 9 ? "\(lapMinutes)" : "0\(lapMinutes)"
        
        //Stopwatch value is stored in stopwatchString formatted with the string for each number (fractions, seconds, minutes) and then set to the stopwatchLabel
        stopwatchString = "\(minutesString):\(secondsString).\(fractionsString)"
        stopwatchLabel.text = stopwatchString
        
        lapString = "\(lapMinutesString):\(lapSecondsString).\(lapFractionsString)"
        
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


