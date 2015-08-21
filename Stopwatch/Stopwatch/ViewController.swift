//
//  ViewController.swift
//  Stopwatch
//
//  Created by Jovanny Espinal on 8/21/15.
//  Copyright © 2015 Jovanny Espinal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var stopwatchLabel: UILabel!
    
    @IBOutlet weak var lapsTableView: UITableView!
    
    @IBOutlet weak var startStopButton: UIButton!
    
    @IBOutlet weak var lapsResetButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startStop(sender: AnyObject) {
        
    }

    @IBAction func lapsReset(sender: AnyObject) {
    
    }
    
    //TableView Methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        
        cell.backgroundColor = self.view.backgroundColor
        
        
        cell.textLabel!.text = "Lap"
        
        cell.detailTextLabel?.text = "00:00:00"
        
        return cell
        

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
}


