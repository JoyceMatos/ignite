//
//  ViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 12/29/16.
//  Copyright © 2016 Joyce Matos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let store = QuoteDataStore.shared
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.getQuotes { 
            print("GETTING CALLED")
        }
    }
}

