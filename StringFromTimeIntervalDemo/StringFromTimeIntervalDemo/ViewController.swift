//
//  ViewController.swift
//  StringFromTimeIntervalDemo
//
//  Created by Z on 8/29/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var timeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBAction func convertTimeButton(sender: AnyObject) {
        if let timeInput = timeTextField.text{
            timeLabel.text = stringFromTimeInterval((timeInput as NSString).doubleValue)
        }
    }
    
    func stringFromTimeInterval(interval: CFTimeInterval) -> String{
        let intInterval = Int(interval)
        
        let years = (intInterval / 31556900)
        let months = (intInterval / 2629740) % 12
        let days = (intInterval / (3600 * 24)) % 365
        let hours = (intInterval / 3600) % 24
        let minutes = (intInterval / 60) % 60
        let seconds = intInterval % 60
        let milliseconds = Int(floor(((interval - floor(interval)) * 100)))
        
        let timeUnits = [years, months, days, hours, minutes, seconds, milliseconds]
        
        var foundFirstNonzero = false
        var timeString = ""

        // remove leading 0s
        for (idx, unit) in timeUnits.enumerate() {
            if unit == 0 && !foundFirstNonzero {
                continue
            }
            foundFirstNonzero = true
            let unitString = unit > 9 ? "\(unit)" : "0\(unit)"
            if idx == timeUnits.count - 1 {
                timeString = timeString + unitString
            } else {
                timeString = timeString + unitString + ":"
            }
        }
        
        return timeString
    }


}

