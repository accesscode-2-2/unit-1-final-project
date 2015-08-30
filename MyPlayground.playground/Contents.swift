//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


var a:Int = 365
var b:Int = 365

let q = b/a

extension NSTimeInterval{
    
    func stringFromTimeInterval(withMilliseconds:Bool) -> String{
        
        let years = (self / 31556900)
        let months = (self / 2629740) % 12
        let days = (self / (3600 * 24)) % 365
        let hours = (self / 3600) % 24
        let minutes = (self / 60) % 60
        let seconds = self % 60
        let milliseconds = floor(((self - floor(self)) * 100))
        
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

let NS








