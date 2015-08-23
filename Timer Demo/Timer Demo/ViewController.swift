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
    let poopTimer = Timer.init(startTime: 45.000)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLink = CADisplayLink(target: self, selector: Selector("update"))
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        
        addTimer(popcornTimer)
        addTimer(poopTimer)
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
        
        cell.timer = timers[indexPath.row]
        
        cell.timerLabel.text = String(cell.timer.remainingTime)
        
        cell.startPauseButton.tag = indexPath.row
        
        cell.startPauseButton.addTarget(self, action: "startPause:", forControlEvents: UIControlEvents.TouchUpInside)

        
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return timers.count
    }
    
    @IBAction func startPause(sender: UIButton){
        
        for path in tableView.indexPathsForVisibleRows! {
            let cell = tableView.cellForRowAtIndexPath(path) as! TableViewCell
            
            if sender.tag == path.row{
                cell.timer.isPaused = true
            }
            
        }
    
    }
    
    
}