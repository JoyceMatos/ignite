//
//  TimePreferenceViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 1/5/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit
import UserNotifications

class TimePreferenceViewController: UIViewController{
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    let store = QuoteDataStore.shared
    let defaults = UserDefaults.standard
    let currentDate = Date()
    let chosenTimeforDay = Date()
    
    @IBAction func setTimeButton(_ sender: Any) {
        
        // TODO: - Change animation and add Time image spin
        sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6.0, options: .allowUserInteraction, animations: { [weak self] in sender.transform = .identity }, completion: nil)
        
        let chosenTimeforDay = timePicker.date
        let dateFormatter = DateFormatter()
        print("Test With Picker: \(chosenTimeforDay)")

        
        // Store chosen time in user defaults
        
        defaults.set(chosenTimeforDay, forKey: "chosenTime")
        guard let storredDefault = defaults.object(forKey: "chosenTime") as? Date else { print("byeDefault"); return }
        print("This is the stored default: \(storredDefault)")

        // Initiate daily notifications
        
        let dailyNotifier = DailyNotification()
        dailyNotifier.scheduleLocal(on: storredDefault)
        
        // hasSeenQuote set to false
        hasSeenQuote()
        
        performSegue(withIdentifier: "showTabBar", sender: self)

        }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        instructionLabel.sizeToFit()
        timePicker.datePickerMode = .time
    
        // Request authorization for notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (didAllow, error) in
            
            if !didAllow {
                // TODO:- notify user's that they will be unable to receive notifications
            }
        }
    }
    
    // This is called twice and can be turned into a protocol
    func hasSeenQuote(_ value: Bool = false) {
        
        defaults.set(value, forKey: "hasSeenQuote")
        print("USERDEFAULT: hasSeenQuote ----> \(value)")
        
    }


}
