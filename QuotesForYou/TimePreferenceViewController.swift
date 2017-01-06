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
    
    
    let currentDate = Date()
    let chosenTimeforDay = Date()
    
    @IBAction func setTimeButton(_ sender: Any) {
        
        let chosenTimeforDay = timePicker.date
        let dateFormatter = DateFormatter()
        
        print("Test With Picker: \(chosenTimeforDay)")
        

        // ----------- TESTING WITH DUMMY CURRENT DATE ------------- \\
//        var testingCurrent = "07-01-2017 10:00"
//        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
//        var currentDate = dateFormatter.date(from: testingCurrent)!
//        print("Test: \(currentDate)")
        
        
        
        if chosenTimeforDay.compare(currentDate) == .orderedAscending {
            
            print ("Chosen Date is earlier than currentDate")

            var calculateChosen = Calendar.current.date(byAdding: .day, value: 1, to: chosenTimeforDay)
            
            if currentDate >= chosenTimeforDay {
                
                //  Eventually, these lines of code can be a protocol or extension
                
                print("New TestDate is one step closer to displaying quote")
                let chosenHour = Calendar.current.component(.hour, from: chosenTimeforDay)
                let chosenMin = Calendar.current.component(.minute, from: chosenTimeforDay)
                
                let currentHour = Calendar.current.component(.hour, from: currentDate)
                let currentMin = Calendar.current.component(.minute, from: currentDate)
                
                if (currentHour, currentMin) >= (chosenHour, chosenMin) {
                    print("YES! SHOW QUOTE")
                } else {
                    print("Ehh, gotta wait a little longer")
                }
            }
            
        } else if currentDate.compare(chosenTimeforDay) == .orderedSame {
            print("New TestDate is the same as Chosen Date")
            print("New TestDate is one step closer to displaying quote")
            let chosenHour = Calendar.current.component(.hour, from: chosenTimeforDay)
            let chosenMin = Calendar.current.component(.minute, from: chosenTimeforDay)
            
            let currentHour = Calendar.current.component(.hour, from: currentDate)
            let currentMin = Calendar.current.component(.minute, from: currentDate)
            
            if (currentHour, currentMin) >= (chosenHour, chosenMin) {
                print("YES! SHOW QUOTE")
            } else {
                print("Ehh, gotta wait a little longer")
            }
        }

    }
    
    @IBAction func testNotificationButton(_ sender: Any) {
        
        //Call dailynotification's schedule function
        // Look up a class struct or how to call a function on a class
        DailyNotification.scheduleLocal()
        
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


}
