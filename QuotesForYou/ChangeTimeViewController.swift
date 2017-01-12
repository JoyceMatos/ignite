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

    
    @IBAction func setTimeButton(_ sender: Any) {
        
        let chosenTimeforDay = timePicker.date
        let dateFormatter = DateFormatter()
        print("Test With Picker: \(chosenTimeforDay)")
        
        
        // Store chosen time in user defaults
        
        defaults.set(chosenTimeforDay, forKey: "chosenTime")
        guard let storredDefault = defaults.object(forKey: "chosenTime") as? Date else { print("byeDefault"); return }
        print("This is the stored default: \(storredDefault)")
        
        // NOTE: - This is in test mode
        // TODO: - Remove test data from scheduleLocal function
        
        
        let dailyNotifier = DailyNotification()
        dailyNotifier.scheduleLocal(on: storredDefault)
        
       // DailyNotification.scheduleLocal(on: storredDefault)

        
        
        
        
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        instructionLabel.sizeToFit()
        
        timePicker.datePickerMode = .time
        

        
        }

   
}
