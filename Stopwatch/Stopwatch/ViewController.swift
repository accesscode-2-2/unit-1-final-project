//
//  ViewController.swift
//  Stopwatch
//
//  Created by Jovanny Espinal on 8/21/15.
//  Copyright © 2015 Jovanny Espinal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
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
    var startStopWatch: Bool = true
    var addLap: Bool = false
    
    

    @IBOutlet weak var stopwatchLabel: UILabel!
    
    @IBOutlet weak var lapsTableView: UITableView!
    
    @IBOutlet weak var startStopButton: UIButton!
    
    @IBOutlet weak var lapsResetButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //When the app is first launched, the stopwatchLabel is set to 0
        stopwatchLabel.text = "00.00.00"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // Actions
    
    @IBAction func startStop(sender: AnyObject) {
        
        if startStopWatch == true {
            
            //Timer is incremented every 0.01 of a second while the startStopWatch is set to true and calls the updateStopwatch method
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateStopwatch"), userInfo: nil, repeats: true)
            lapTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: ("updateStopwatch"), userInfo: nil, repeats: true)
            
            
            //The startStopWatch will turn false when the Start button is clicked (so that it can turn true when the Stop button is clicked)
            startStopWatch = false
            
            // When the button reads Start and is clicked, it will change into a Stop button while the timer is firing.
            startStopButton.setImage(UIImage(named: "stop.png"), forState: UIControlState.Normal)
            
            // When the button reads Start and is clicked, it will change the Lap button into a Reset button while the timer is firing.
            lapsResetButton.setImage(UIImage(named: "lap.png"), forState: UIControlState.Normal)
            
            
            // When the button reads Start, it allows for laps to be added. (refer to the lapsReset method)
            addLap = true
            
        }
        
        else {
            
            // When the Stop button is clicked, it invalidates the timer
            timer.invalidate()
            lapTimer.invalidate()
            
            // The startStopWatch will turn true when the Stop button is clicked (so that it can turn false when the Start button is clicked)
            startStopWatch = true
            
            // When the button reads Stop and is clicked, it will change into a Start button while the timer is invalidated.
            startStopButton.setImage(UIImage(named: "start.png"), forState: .Normal)
            
            // When the button reads Stop and is clicked, it will change the Reset button into a Lap button while the timer is invalidated.
            lapsResetButton.setImage(UIImage(named: "reset.png"), forState: .Normal)
            
            // When the buttons reads Stop and is clicked, it allows for the stopwatch and laps to be reset (refer to the lapsReset method)
            addLap = false
            
        }
        
    }
    
    func updateStopwatch() {
        
        // Increments the fraction of a second by 1
        fractions += 1
        lapFractions += 1
        
        // If the fractions of the a second reaches 100, seconds is incremented by 1
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
        // The values are a shorthand form of writing if/else statements. Condition ? Result if true : Result if false
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

    @IBAction func lapsReset(sender: AnyObject) {
    
        
        if addLap == true {
            
            //Adds the current time, which is stored in lapString (refer to the updateStopWatch method)
            laps.insert(lapString, atIndex: 0)
            
            //Resets the lap counter
            lapFractions = 0
            lapSeconds = 0
            lapMinutes = 0
            
            lapString = "00:00.00"
            
            //Refreshes the table view that contains the lap times
            lapsTableView.reloadData()
            
        }
        else {
            
            addLap == false
            
            // When the button reads Reset and is clicked, it will change into a Lap button and reset the stopwatchString (just the string) back to 0.
            lapsResetButton.setImage(UIImage(named: "lap.png"), forState: .Normal)
            
            // When the button reads Reset and is clicked, it will remove all elements in the laps array and then reload the table view
            laps.removeAll(keepCapacity: false)
            lapsTableView.reloadData()
            
            // Reverts the time back to 0
            fractions = 0
            seconds = 0
            minutes = 0
            
            lapFractions = 0
            lapSeconds = 0
            lapMinutes = 0
            
            lapString = "00:00.00"
            
            stopwatchString = "00:00.00"
            stopwatchLabel.text = stopwatchString
            
        }
        
    }
    
    //TableView Methods
    
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


