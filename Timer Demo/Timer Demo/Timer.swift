//
//  Timer.swift
//  Timer Demo
//
//  Created by Z on 8/22/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

import UIKit

class Timer: NSObject {
    
    var timerName : String
    var startTime: CFTimeInterval!
    var remainingTime: CFTimeInterval!
    var isPaused = true
    
    
    init(timerLabel: String, startTime:CFTimeInterval){
        self.startTime = startTime
        self.remainingTime = startTime
        self.timerName = timerLabel
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
    
}
