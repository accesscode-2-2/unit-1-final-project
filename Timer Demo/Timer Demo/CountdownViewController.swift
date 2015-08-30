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
    var targetDates : [NSDate] = []

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
        return targetDates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CountdownCell", forIndexPath: indexPath) as! CountdownTableViewCell
        
        cell.targetDate = targetDates[indexPath.row]
        cell.countdownLabel.text = timeToTargetDate(cell.targetDate!).stringFromTimeInterval(false)
        
        return cell
    }
    
    //MARK: AddCountdownViewControllerDelegate method
    func addCountdownViewController(viewController: AddCountdownViewController, didCreateNewCountdown targetDate: NSDate, name: String) {
        targetDates.append(targetDate)
    }
    
    //MARK: Segue methods
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let viewController = segue.destinationViewController as? AddCountdownViewController {
            viewController.delegate = self
        }
    }
    
}
