//
//  ChangeTimeViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 1/7/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class ChangeTimeViewController: UIViewController {
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var setTimeButton: UIButton!
    
    let chosenTimeforDay = Date()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    @IBAction func setTimeButton(_ sender: UIButton) {
        let chosenTimeforDay = timePicker.date        
        
        // Store chosen time in user defaults
        defaults.set(chosenTimeforDay, forKey: UserDefaultKey.chosenTime)
        
        guard let storredDefault = defaults.object(forKey: UserDefaultKey.chosenTime) as? Date else {
            print("byeDefault")
            return
        }
        
        let hr = Calendar.current.component(.hour, from: storredDefault)
        let min = Calendar.current.component(.minute, from: storredDefault)
        
        if hr < 12 && hr > 0 {
            let m = String(format: "%2d", min)
            currentTimeLabel.text = "\(hr):\(m) AM"
        } else if hr == 12 {
            let m = String(format: "%2d", min)
            currentTimeLabel.text = "\(12):\(m) PM"
        } else if hr == 0 {
            let m = String(format: "%2d", min)
            currentTimeLabel.text = "\(12):\(m) AM"
        }else {
            let m = String(format: "%2d", min)
            let h = String(format: "%2d", (hr - 12))
            currentTimeLabel.text = "\(h):\(m) PM"
        }
        
        // Initiate daily notifications
        let dailyNotifier = DailyNotification()
        dailyNotifier.scheduleLocal(on: storredDefault)
        
        // Add an alert
        guard let currentTime = currentTimeLabel.text else {
            return
        }
        
        animateButtonToUpdate()
        addAlert(currentTime)
        
    }
    
    func configureViews() {
        guard let storedTime = defaults.object(forKey: UserDefaultKey.chosenTime) as? Date else {
            print("noChosenTimeToConfigure: byeDefault")
            return
        }
        
        let hr = Calendar.current.component(.hour, from: storedTime)
        let min = Calendar.current.component(.minute, from: storedTime)
        
        if hr < 12 && hr > 0 {
            let m = String(format: "%2d", min)
            currentTimeLabel.text = "\(hr):\(m) AM"
        } else if hr == 12 {
            let m = String(format: "%2d", min)
            currentTimeLabel.text = "\(12):\(m) PM"
        } else if hr == 0 {
            let m = String(format: "%2d", min)
            currentTimeLabel.text = "\(12):\(m) AM"
        } else {
            let m = String(format: "%2d", min)
            let h = String(format: "%2d", (hr - 12))
            currentTimeLabel.text = "\(h):\(m) PM"
        }

        instructionLabel.sizeToFit()
        
        timePicker.datePickerMode = .time
        
        
    }
    
    func addAlert(_ time: String) {
        let alertController = UIAlertController(title: "Reminder", message: "Your reminder has been updated to: \(time)", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.animateButtonToOriginalState()
        }

        alertController.addAction(okAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    // TODO: - Refactor
    
    func animateButtonToUpdate() {
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
        transition.duration = 0.5
        setTimeButton.titleLabel?.layer.add(transition, forKey: kCATransition)
        setTimeButton.setTitle("Updating Reminder...", for: .normal)
        setTimeButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    func animateButtonToOriginalState() {
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
        transition.duration = 0.5
        setTimeButton.titleLabel?.layer.add(transition, forKey: kCATransition)
        setTimeButton.setTitle("Set Time", for: .normal)
        setTimeButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    
}
