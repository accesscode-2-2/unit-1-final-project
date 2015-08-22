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
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startPauseButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var displayLink : CADisplayLink!
    var timers: [Timer] = [];
    let popcornTimer = Timer.init(startTime: 30.000)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLink = CADisplayLink(target: self, selector: Selector("update"))
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        
        addTimer(popcornTimer)
        
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
        
        tableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell
        
        cell.timerLabel.text = String(timers[indexPath.row].remainingTime)
        
        cell.startPauseButton.tag = indexPath.row
        
        //ADD TARGET. VIDEO @ 9:00
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timers.count
    }
    
    
}