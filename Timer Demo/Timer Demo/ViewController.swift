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
    var timers: [Timer] = [];
    let popcornTimer = Timer.init(startTime: 30.000)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLink = CADisplayLink(target: self, selector: Selector("update"))
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func addTimer(timer:Timer){
        timers.append(timer)
    }
    
    func updateTimer(timer:Timer){
        timer.remainingTime = timer.remainingTime - displayLink.duration
        print("Remaining time: \(timer.remainingTime)")
    }
    
    func update(){
        for timer in timers{
            if timer.isPaused == false{
                updateTimer(timer)
            }
        }
    }
    
    
    
    
    
}