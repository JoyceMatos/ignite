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
    
    let chosenTimeforDay = Date()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    @IBAction func setTimeButton(_ sender: UIButton) {
        
        // TODO: - Change animation and add Time image spin
        sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6.0, options: .allowUserInteraction, animations: { [weak self] in
            
            sender.transform = .identity
          //  sender.setImage(#imageLiteral(resourceName: "Time"), for: .normal)
            
            }, completion: nil)
        
        let chosenTimeforDay = timePicker.date        
        
        // Store chosen time in user defaults
        
        defaults.set(chosenTimeforDay, forKey: "chosenTime")
        guard let storredDefault = defaults.object(forKey: "chosenTime") as? Date else { print("byeDefault"); return }
        
        let hr = Calendar.current.component(.hour, from: storredDefault)
        let min = Calendar.current.component(.minute, from: storredDefault)
        
        if hr < 12 && hr > 0 {
            let m = String(format: "%02d", min)
            currentTimeLabel.text = "\(hr):\(m) AM"
        } else if hr == 12 {
            let m = String(format: "%02d", min)
            currentTimeLabel.text = "\(12):\(m) PM"
        } else if hr == 0 {
            let m = String(format: "%02d", min)
            currentTimeLabel.text = "\(12):\(m) AM"
        }else {
            let m = String(format: "%02d", min)
            let h = String(format: "%02d", (hr - 12))
            currentTimeLabel.text = "\(h):\(m) PM"
        }
        
        // Initiate daily notifications
        
        let dailyNotifier = DailyNotification()
        dailyNotifier.scheduleLocal(on: storredDefault)
        
        
    }
    
    func configureViews() {
        
        guard let storedTime = defaults.object(forKey: "chosenTime") as? Date else { print("noChosenTimeToConfigure: byeDefault"); return }
        
        let hr = Calendar.current.component(.hour, from: storedTime)
        let min = Calendar.current.component(.minute, from: storedTime)
        
        if hr < 12 && hr > 0 {
            let m = String(format: "%02d", min)
            currentTimeLabel.text = "\(hr):\(m) AM"
        } else if hr == 12 {
            let m = String(format: "%02d", min)
            currentTimeLabel.text = "\(12):\(m) PM"
        } else if hr == 0 {
            let m = String(format: "%02d", min)
            currentTimeLabel.text = "\(12):\(m) AM"
        } else {
            let m = String(format: "%02d", min)
            let h = String(format: "%02d", (hr - 12))
            currentTimeLabel.text = "\(h):\(m) PM"
        }

        
        instructionLabel.sizeToFit()
        
        timePicker.datePickerMode = .time
        
        
    }
    
    
}
