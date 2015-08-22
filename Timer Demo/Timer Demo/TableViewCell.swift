//
//  TableViewCell.swift
//  Timer Demo
//
//  Created by Jovanny Espinal on 8/22/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startPauseButton: UIButton!
    var timerString : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.timerLabel.text = timerString
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
