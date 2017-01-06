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
    
    @IBAction func setTimeButton(_ sender: Any) {
        
        print(timePicker.date.timeIntervalSince1970)
        
        // 9:09 AM ------ 1483625374.0
        // 9:00 AM ------ 1483668015.0
        // 9:00 PM ------ 1483668056.0
        
        
        // One hour ago
        
        let earlyDate = NSCalendar.currentCalendar.date
        
        
        dateByAddingUnit(
            .Hour,
            value: -1,
            toDate: NSDate(),
            options: [])



        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        timePicker.datePickerMode = .time
        // Do any additional setup after loading the view.
    }


}
