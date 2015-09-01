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
    
    init(name: String, startTime:CFTimeInterval){
        self.startTime = startTime
        self.remainingTime = startTime
        self.timerName = name
    }
    
}
