//
//  MasterViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 1/7/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       let isLoggedIn = false
        
        if isLoggedIn {
            // Send to quote view
        } else {
            perform(#selector(showTimeController), with: nil, afterDelay: 0.01)
        }
    }
    
    func showTimeController() {
        let timeController = TimePreferenceViewController()
        present(timeController, animated: true, completion: {
            
            // do something here
        })
        
        
    }
    
    
    
}
