//
//  ViewController.swift
//  Timer Demo
//
//  Created by Z on 8/22/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var displayLink : CADisplayLink!
    var timers: [Timer] = [];
    let popcornTimer = Timer.init(timerLabel: "Popcorn", startTime: 4.000)
    let poopTimer = Timer.init(timerLabel: "Poop", startTime: 3.000)
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("LoudAlarmClockBuzzer", ofType: "mp3")!)
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: alertSound)
        }   catch {
            print("Error")
        }
        
        audioPlayer.numberOfLoops = -1
        audioPlayer.prepareToPlay()
        
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
                if (timer.remainingTime < 0.0){
                    audioPlayer.play()
                    displayAlert()
                    
                    timer.isPaused = true
                }
            }
            tableView.reloadData()
        }
    }
    
    func displayAlert(){
        let alertController = UIAlertController(title: "Time's up!", message: nil, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
            self.audioPlayer.stop()
        }
        
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true, completion:nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell
        
        let timer = timers[indexPath.row]
        
        cell.timer = timer
        
        cell.timerName.text = cell.timer.timerName
        cell.timerLabel.text = String(cell.timer.stringFromTimeInterval(cell.timer.remainingTime))
        
        
        if timer.isPaused {
            cell.startPauseButton.setImage(UIImage(named: "Start-50.png"), forState: .Normal)
            cell.timer.remainingTime = cell.timer.startTime
        }
        else {
            cell.startPauseButton.setImage(UIImage(named: "Cancel-50.png"), forState: .Normal)
        }
        
        cell.startPauseButton.tag = indexPath.row
        
        cell.startPauseButton.addTarget(self, action: "startPause:", forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.progressBar.progress = Float((cell.timer.remainingTime/cell.timer.startTime))
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return timers.count
    }
    
    @IBAction func startPause(startPauseButton: UIButton){
        
        for path in tableView.indexPathsForVisibleRows! {
            let cell = tableView.cellForRowAtIndexPath(path) as! TableViewCell
            
            if startPauseButton.tag == path.row {
                cell.timer.isPaused = !cell.timer.isPaused
            }
        }
    }
    
    
}