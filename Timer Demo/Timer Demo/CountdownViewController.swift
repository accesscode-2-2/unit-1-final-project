//
//  CountdownViewController.swift
//  Countdown
//
//  Created by Z on 8/29/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController,
    UITableViewDataSource,
    UITableViewDelegate,
    AddCountdownViewControllerDelegate {
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    
    var displayLink : CADisplayLink!
    var countdowns : [Countdown] = []

    @IBOutlet weak var dateForCountdownLabel: UILabel!
    @IBOutlet weak var timeForCountdownLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLink = CADisplayLink(target: self, selector: Selector("update"))
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func update(){
        tableView.reloadData()
    }
    
    //MARK: TableView methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countdowns.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CountdownCell", forIndexPath: indexPath) as! CountdownTableViewCell
        
        cell.countdown = countdowns[indexPath.row]
        cell.countdownNameLabel.text = cell.countdown!.name
        
        if timeToTargetDate(cell.countdown!.targetDate) > 0 {
            cell.countdownLabel.text = timeToTargetDate(cell.countdown!.targetDate).stringFromTimeInterval(false)
            cell.updateLabelVisibilities()
        } else{
            cell.countdownLabel.text = cell.countdown!.targetDate.timeAgo
            cell.hideAllLabelView()
        }
        
        let sgr = UISwipeGestureRecognizer(target: self, action: cellSwiped:)
//        [cell addGestureRecognizer:sgr];
//        [sgr release];
        
        return cell
    }
    
    func cellSwiped(){
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let countdown = countdowns[indexPath.row] as Countdown
        let dateAndTime = dateAndTimeStringsfromDate(countdown.targetDate)
        
        dateForCountdownLabel.text = (dateAndTime as NSArray).objectAtIndex(0) as? String
        timeForCountdownLabel.text = (dateAndTime as NSArray).objectAtIndex(1)as? String
    }
    
    //need to fix delete method
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.beginUpdates()
        countdowns.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Bottom)
        tableView.endUpdates()
    }
    
    
    //MARK: AddCountdownViewControllerDelegate method
    func addCountdownViewController(viewController: AddCountdownViewController, didCreateNewCountdown countdown: Countdown) {
        countdowns.append(countdown)
    }
    
    //MARK: Segue methods
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let viewController = segue.destinationViewController as? AddCountdownViewController {
            viewController.delegate = self
        }
    }
}
