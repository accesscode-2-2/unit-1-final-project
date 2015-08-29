//
//  CountdownViewController.swift
//  Countdown
//
//  Created by Z on 8/29/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {
    

    @IBOutlet weak var timeToTargetDateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var displayLink : CADisplayLink!
    var targetDate = NSDate()

    override func viewDidLoad() {
        displayLink = CADisplayLink(target: self, selector: Selector("updateTimeToTargetDate"))
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }

    @IBAction func datePickerValueChanged(sender: UIDatePicker) {
        targetDate = datePicker.date
        updateTimeToTargetDate()
    }
    
    func updateTimeToTargetDate(){
        let currentDate = NSDate()
        let timeToTargetDate = targetDate.timeIntervalSinceDate(currentDate)
        timeToTargetDateLabel.text = timeToTargetDate.stringFromTimeInterval(false)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
