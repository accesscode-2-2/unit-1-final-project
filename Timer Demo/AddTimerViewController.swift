//
//  AddTimerViewController.swift
//  Timer Demo
//
//  Created by Jovanny Espinal on 8/29/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

import UIKit

class AddTimerViewController: UIViewController {

    @IBOutlet weak var timerNameField: UITextField!
    @IBOutlet weak var timerPicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
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

    @IBAction func addTimer(sender: UIBarButtonItem) {
        
        
        
        print("\(stringFromTimeInterval(timerPicker.countDownDuration, withMilliseconds: false))")
        
        self.navigationController?.popViewControllerAnimated(true)
        
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
