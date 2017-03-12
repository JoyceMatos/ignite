//
//  ChangeTimeViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 1/7/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class ChangeTimeViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    let chosenTimeforDay = Date()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instructionLabel.sizeToFit()
        timePicker.datePickerMode = .time
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
        
        // Initiate daily notifications
        
        let dailyNotifier = DailyNotification()
        dailyNotifier.scheduleLocal(on: storredDefault)
        
        
    }
    
    
}
