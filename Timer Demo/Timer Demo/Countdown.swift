//
//  Countdown.swift
//  Timer Demo
//
//  Created by Z on 8/30/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

import UIKit

class Countdown: NSObject {
    
    var name: String
    var targetDate: NSDate
    
    init(name: String, targetDate:NSDate){
        self.name = name
        self.targetDate = targetDate
    }

}
