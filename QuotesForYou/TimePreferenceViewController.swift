//
//  TimePreferenceViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 1/5/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit
import UserNotifications

class TimePreferenceViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    let store = QuoteDataStore.shared
    let defaults = UserDefaults.standard
    let currentDate = Date()
    let chosenTimeforDay = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instructionLabel.sizeToFit()
        timePicker.datePickerMode = .time
        
        requestAuthorization()
        
    }
    
    // MARK: - Action methods
    
    @IBAction func setTimeButton(_ sender: UIButton) {
  
        let chosenTimeforDay = timePicker.date
        
        // Store chosen time in user defaults
        defaults.set(chosenTimeforDay, forKey: UserDefaultKey.chosenTime)
        guard let storredDefault = defaults.object(forKey: UserDefaultKey.chosenTime) as? Date else {
            return
        }
        
        // Initiate daily notifications
        let dailyNotifier = DailyNotification()
        dailyNotifier.scheduleLocal(on: storredDefault)
        
        QuoteDataStore.hasSeenQuote()
        
        performSegue(withIdentifier: SegueIdentifier.showTabBar, sender: self)
        
    }
    
    //  MARK: - Notification methods
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (didAllow, error) in
            
        }
    }
    
    
}


