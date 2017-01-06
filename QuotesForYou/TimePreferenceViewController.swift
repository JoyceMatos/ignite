//
//  TimePreferenceViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 1/5/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class TimePreferenceViewController: UIViewController {
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    let currentDate = Date()
    let chosenTimeforDay = Date()
    let currentDay = Date()
    
    @IBAction func setTimeButton(_ sender: Any) {
        
        print(timePicker.date)
        let chosenTime = timePicker.date
        
        let dateFormatter = DateFormatter()
        
        // ----------- TESTING ------------- \\
        
        var dateChosenAsString = "05-01-2017 13:00"   // "Jan 6, 2015, 1:00 PM"
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var newChosenDate = dateFormatter.date(from: dateChosenAsString)!
        print("Test: \(newChosenDate)")
        
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.date(from: dateChosenAsString)
        
        var testingCurrent = "05-01-2017 13:00"
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var newTestDate = dateFormatter.date(from: testingCurrent)!
        print("Test: \(newTestDate)")
        
        
        
        print("Test: \(currentDate)")
        
        
        if newTestDate.compare(newChosenDate) == .orderedDescending {
            
            // Add 24 hours to chosen time
            // Compare hours
            
            var calculateChosen = Calendar.current.date(byAdding: .day, value: 1, to: newChosenDate)
            
            if newTestDate >= newChosenDate {
                print("New TestDate can display quote")
                let chosenHourComp = Calendar.current.component(.hour, from: newChosenDate)
                let chosenMinComp = Calendar.current.component(.minute, from: newChosenDate)
                
                let testDateComp = Calendar.current.component(.hour, from: newTestDate)
                let testMinComp = Calendar.current.component(.minute, from: newTestDate)
                
                
                if (testDateComp, testMinComp) >= (chosenHourComp, chosenMinComp) {
                    print("YES! SHOW QUOTE")
                } else {
                    print("Ehh, gotta wait a little longer")
                }
                
            }
            
            
            print ("Chosen Date is earlier than currentDate")
        } else if newTestDate.compare(newChosenDate) == .orderedSame {
            print("Chosen Date is the same as currentDate")
            let chosenHourComp = Calendar.current.component(.hour, from: newChosenDate)
            let chosenMinComp = Calendar.current.component(.minute, from: newChosenDate)
            
            let testDateComp = Calendar.current.component(.hour, from: newTestDate)
            let testMinComp = Calendar.current.component(.minute, from: newTestDate)
            
            
            if (testDateComp, testMinComp) >= (chosenHourComp, chosenMinComp) {
                print("YES! SHOW QUOTE")
            } else {
                print("Ehh, gotta wait a little longer")
            }
            
        }


        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        timePicker.datePickerMode = .time
        // Do any additional setup after loading the view.
    }


}
