//
//  AddTimerViewController.swift
//  Timer Demo
//
//  Created by Jovanny Espinal on 8/29/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

import UIKit

protocol AddTimerViewControllerDelegate {
    func addTimerViewController(viewController: AddTimerViewController, didCreateNewTimer timer:Timer)
}

class AddTimerViewController: UIViewController {

    @IBOutlet weak var timerNameField: UITextField!
    @IBOutlet weak var timerPicker: UIDatePicker!
    
    var delegate: AddTimerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerPicker.countDownDuration = 60
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTimerButtonTapped(sender: AnyObject) {
        let newTimer = Timer(timerLabel: timerNameField.text!, startTime: timerPicker.countDownDuration)
        delegate?.addTimerViewController(self, didCreateNewTimer: newTimer)
        self.navigationController?.popViewControllerAnimated(true)
        

    }

    
    func stringFromTimeInterval(interval: CFTimeInterval, withMilliseconds:Bool = true) -> String{
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
            
            if (withMilliseconds == true){
                if idx == timeUnits.count - 1 {
                    timeString = timeString + unitString
                }
                else if (idx == timeUnits.count - 2){
                    timeString = timeString + unitString + "."
                }else{
                    timeString = timeString + unitString + ":"
                }
            }else{
                if idx == timeUnits.count - 1 {
                    //do nothing
                }
                else if (idx == timeUnits.count - 2){
                    timeString = timeString + unitString
                }else{
                    timeString = timeString + unitString + ":"
                }
            }
            
        }
        
        return timeString
    }

//    @IBAction func addTimer(sender: UIBarButtonItem) {
//        
//        
//        
//        
//        print("\(stringFromTimeInterval(timerPicker.countDownDuration, withMilliseconds: false))")
//        
//        self.navigationController?.popViewControllerAnimated(true)
//        
//    }
    

    // MARK: - Navigation


}
