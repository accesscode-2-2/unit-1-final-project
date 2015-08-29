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
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    var timer : Timer!
    var maxWidth : CGFloat = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
