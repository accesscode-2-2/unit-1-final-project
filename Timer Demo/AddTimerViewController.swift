//
//  AddTimerViewController.swift
//  Timer Demo
//
//  Created by Jovanny Espinal on 8/29/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

import UIKit

protocol AddTimerViewControllerDelegate {
    func addTimerViewController(viewController: AddTimerViewController, didCreateNewTimer timer:Timer)
}

class AddTimerViewController: UIViewController {

    @IBOutlet weak var timerNameField: UITextField!
    @IBOutlet weak var timerPicker: UIDatePicker!
    
    var delegate: AddTimerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timerPicker.countDownDuration = 60
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTimerButtonTapped(sender: AnyObject) {
        let newTimer = Timer(name: timerNameField.text!, startTime: timerPicker.countDownDuration)
        delegate?.addTimerViewController(self, didCreateNewTimer: newTimer)
        self.navigationController?.popViewControllerAnimated(true)
    }

}
