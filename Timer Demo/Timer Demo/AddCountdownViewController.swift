//
//  AddCountdownViewController.swift
//  Countdown
//
//  Created by Z on 8/29/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

import UIKit

protocol AddCountdownViewControllerDelegate {
    func addCountdownViewController(viewController: AddCountdownViewController, didCreateNewCountdown countdown:Countdown)
}

class AddCountdownViewController: UIViewController, UITextFieldDelegate {
    
    var delegate: AddCountdownViewControllerDelegate?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var targetDateLabel: UILabel!
    @IBOutlet weak var targetTimeLabel: UILabel!
    @IBOutlet weak var timerNameTextField: UITextField!
    @IBOutlet weak var setCountdownButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerNameTextField.delegate = self
        
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
        if (datePicker.date.timeIntervalSinceNow > 0) && (timerNameTextField.text != nil){
            let newTargetDate = datePicker.date
            let newName = timerNameTextField.text
            let newCountdown = Countdown(name: newName!, targetDate: newTargetDate)
            
            delegate?.addCountdownViewController(self, didCreateNewCountdown: newCountdown)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    //MARK: Textfield methods
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
