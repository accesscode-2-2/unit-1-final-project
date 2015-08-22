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
    
    var minutes: Int = 0
    var seconds: Int = 0
    var fractions: Int = 0
    
    var minutesString: String = ""
    var secondsString: String = ""
    var fractionsString: String = ""
    var stopwatchString: String = ""
    
    var startStopWatch: Bool = true
    var addLap: Bool = false
    
    

    @IBOutlet weak var stopwatchLabel: UILabel!
    
    @IBOutlet weak var lapsTableView: UITableView!
    
    @IBOutlet weak var startStopButton: UIButton!
    
    @IBOutlet weak var lapsResetButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        stopwatchLabel.text = "00.00.0"
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
            
            
            //The startStopWatch will turn false when the Start button is clicked (so that it can turn true when the Stop button is clicked)
            startStopWatch = false
            
            // When the button reads Start and is clicked, it will change into a Stop button while the timer is firing.
            startStopButton.setImage(UIImage(named: "stop.png"), forState: UIControlState.Normal)
            
            // When the button reads Start and is clicked, it will change the Lap button into a Reset button while the timer is firing.
            lapsResetButton.setImage(UIImage(named: "lap.png"), forState: UIControlState.Normal)
            
            addLap = true
            
        }
        
        else {
            
            // When the Stop button is clicked, it invalidates the timer
            timer.invalidate()
            
            // The startStopWatch will turn true when the Stop button is clicked (so that it can turn false when the Start button is clicked)
            startStopWatch = true
            
            // When the button reads Stop and is clicked, it will change into a Start button while the timer is invalidated.
            startStopButton.setImage(UIImage(named: "start.png"), forState: .Normal)
            
            // When the button reads Stop and is clicked, it will change the Reset button into a Lap button while the timer is invalidated.
            lapsResetButton.setImage(UIImage(named: "reset.png"), forState: .Normal)
            
            addLap = false
            
        }
    }
    
    func updateStopwatch() {
        
        // Increments the fraction of a second by 1
        fractions += 1
        
        // If the fractions of the a second reaches 100, seconds is incremented by 1
        if fractions == 100 {
            
            seconds += 1
            fractions = 0
        }
        
        // If the second reaches 60, minute is incremented by 1 and sets seconds to 0
        if seconds == 60 {
            
            minutes += 1
            seconds = 0
        }
        
        
        // Sets the strings for fractions, seconds, and minutes. If any number is greater than 9, display a 0 before it.
        // The values are a shorthand form of writing if/else statements. Condition ? Result if true : Result if false
        fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        
        //Stopwatch value is stored in stopwatchString formatted with the string for each number (fractions, seconds, minutes) and then set to the stopwatchLabel
        stopwatchString = "\(minutesString):\(secondsString).\(fractionsString)"
        stopwatchLabel.text = stopwatchString
        
        
    }

    @IBAction func lapsReset(sender: AnyObject) {
    
    }
    
    //TableView Methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        
        cell.backgroundColor = self.view.backgroundColor
        
        
        cell.textLabel!.text = "Lap"
        
        cell.detailTextLabel?.text = "00:00:00"
        
        return cell
        

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
}


