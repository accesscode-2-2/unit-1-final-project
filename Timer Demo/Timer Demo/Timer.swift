//
//  Timer.swift
//  Timer Demo
//
//  Created by Z on 8/22/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

import UIKit

class Timer: NSObject {
    
    var startTime: CFTimeInterval!
    var remainingTime: CFTimeInterval!
    var isPaused = true
    
    
    init(startTime:CFTimeInterval){
        self.startTime = startTime
        self.remainingTime = startTime
    }
    
//    func stringFromTimeInterval(interval: CFTimeInterval) -> String{
//        let intInterval = Int(interval)
//        let minutes = (intInterval / 60) % 60
//        let seconds = intInterval % 60
//        let milliseconds = Int(floor(((interval - floor(interval)) * 100)))
//        
//        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
//        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
//        let millisecondsString = milliseconds > 9 ? "\(milliseconds)" : "0\(milliseconds)"
//        
//        let timeString = minutesString + ":" + secondsString + "." + millisecondsString
//        
//        return timeString
//    }
    
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
        
        var timeString = ""
        for unit in timeUnits{
            let unitString = unit > 9 ? "\(unit)" : "0\(unit)"
            if unit > 0 {
                timeString = timeString + unitString + ":"
            }
        }
        
      return timeString
    }
}
