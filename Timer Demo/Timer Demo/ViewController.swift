//
//  ViewController.swift
//  Timer Demo
//
//  Created by Z on 8/22/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel!.text = "Test"
        cell.detailTextLabel!.text = "Detail Test"
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
}