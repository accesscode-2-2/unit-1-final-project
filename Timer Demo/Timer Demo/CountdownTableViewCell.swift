//
//  CountdownTableViewCell.swift
//  Timer Demo
//
//  Created by Z on 8/30/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

import UIKit

class CountdownTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var monthsLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!
    
    var unitLabels = []
    var targetDate : NSDate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        countdownLabel.adjustsFontSizeToFitWidth = true;
        unitLabels = [yearsLabel, monthsLabel, daysLabel, hoursLabel, minutesLabel, secondsLabel]
        updateLabelVisibilities()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func updateLabelVisibilities() {
        guard let date = self.targetDate where self.targetDate != nil else { return }
        
        let largestTimeUnit = timeToTargetDate(date).largestTimeUnit()
        
        for (idx,label) in unitLabels.enumerate(){
            let mapIdx = idx + 1 //since no ms label
            if (mapIdx > largestTimeUnit.rawValue){ //raw value for years is 0
                (label as! UILabel).hidden = false
            }
            else{
                (label as! UILabel).hidden = true
            }
        }
    }
}
