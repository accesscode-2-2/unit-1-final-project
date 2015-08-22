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
    var isPaused = false
    
    init(startTime:CFTimeInterval){
        self.startTime = startTime
        self.remainingTime = startTime
    }    
}
