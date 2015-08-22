//
//  ViewController.swift
//  Timer Demo
//
//  Created by Z on 8/22/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    var displayLink : CADisplayLink!
    var timers = [];
    let popcornTimer = Timer.init(startTime: 30.000)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLink = CADisplayLink(target: self, selector: Selector("updateTimer"))
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func updateTimer(){
        popcornTimer.remainingTime = popcornTimer.remainingTime - displayLink.duration
        print("Remaining popcorn time: \(popcornTimer.remainingTime)")
    }
}

