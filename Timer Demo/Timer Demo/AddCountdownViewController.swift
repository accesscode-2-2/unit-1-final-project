//
//  AddCountdownViewController.swift
//  Countdown
//
//  Created by Z on 8/29/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

import UIKit

protocol AddCountdownViewControllerDelegate {
    func addCountdownViewController(viewController: AddCountdownViewController, didCreateNewCountdown targetDate:NSDate, name:String)
}

class AddCountdownViewController: UIViewController {
    
    var delegate: AddCountdownViewControllerDelegate?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var targetDateLabel: UILabel!
    @IBOutlet weak var targetTimeLabel: UILabel!
    @IBOutlet weak var timerNameTextField: UITextField!
    @IBOutlet weak var setCountdownButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateDateAndTimeLabel()
    }
    
    func updateDateAndTimeLabel(){
        let dateAndTime = dateAndTimeStringsfromDate(datePicker.date)
        targetDateLabel.text = (dateAndTime as NSArray).objectAtIndex(0) as? String
        targetTimeLabel.text = (dateAndTime as NSArray).objectAtIndex(1)as? String
    }
    
    @IBAction func datePickerValueChanged(sender: UIDatePicker) {
        updateDateAndTimeLabel()
    }
    
    @IBAction func setCountdownButtonTapped(sender: UIButton) {
        if datePicker.date.timeIntervalSinceNow > 0 { //makes sure that target date is in the future
            let newTargetDate = datePicker.date
            delegate?.addCountdownViewController(self, didCreateNewCountdown: newTargetDate, name:timerNameTextField.text!)
            self.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    func dateAndTimeStringsfromDate(date:NSDate) -> ([String]){
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        formatter.timeStyle = .MediumStyle
        let fullString = formatter.stringFromDate(datePicker.date)
        return (fullString.componentsSeparatedByString(" at "))
    }
}
