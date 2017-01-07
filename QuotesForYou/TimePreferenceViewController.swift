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
        
        let chosenTimeforDay = timePicker.date
        let dateFormatter = DateFormatter()
        print("Test With Picker: \(chosenTimeforDay)")

        
        // Store chosen time in user defaults
        
        defaults.set(chosenTimeforDay, forKey: "chosenTime")
        guard let storredDefault = defaults.object(forKey: "chosenTime") as? Date else { print("byeDefault"); return }
        print("This is the stored default: \(storredDefault)")

        // NOTE: - This is in test mode
        // TODO: - Remove test data from scheduleLocal function
        DailyNotification.scheduleLocal(on: storredDefault)
    
        
        performSegue(withIdentifier: "showTabBar", sender: self)

        
        
        // TODO:- Add launch screen to user defaults; next time it opens ---> strait to quotes page.
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        instructionLabel.sizeToFit()
        
        timePicker.datePickerMode = .time

    //    UNUserNotificationCenter.current().delegate = self
    
        // Request authorization for notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (didAllow, error) in
            
            if !didAllow {
                // TODO:- notify user's that they will be unable to receive notifications
            }
        }
    }
    

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "showTabBar" {
//            
//            let destination = segue.destination as! ViewController
//
//            
//        }
//        
//    }


}
