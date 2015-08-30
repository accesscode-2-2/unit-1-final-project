//
//  CountdownViewController.swift
//  Countdown
//
//  Created by Z on 8/29/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController, AddCountdownViewControllerDelegate {
    
    @IBOutlet weak var timeToTargetDateLabel: UILabel!
    var targetDate : NSDate?
    var displayLink : CADisplayLink!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLink = CADisplayLink(target: self, selector: Selector("updateTimeToTargetDate"))
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func updateTimeToTargetDate(){
        if let setTargetDate = targetDate{
            let currentDate = NSDate()
            let timeToTargetDate = setTargetDate.timeIntervalSinceDate(currentDate)
            timeToTargetDateLabel.text = timeToTargetDate.stringFromTimeInterval(false)
        }
    }
    
    //MARK: AddCountdownViewControllerDelegate method
    func addCountdownViewController(viewController: AddCountdownViewController, didCreateNewCountdown targetDate: NSDate) {
        self.targetDate = targetDate
    }
    
    //MARK: Segue methods
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let viewController = segue.destinationViewController as? AddCountdownViewController {
            viewController.delegate = self
        }
    }
    
}
