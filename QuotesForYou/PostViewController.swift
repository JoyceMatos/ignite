//
//  PostViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 2/22/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var addQuoteTextView: UITextView!
    @IBOutlet weak var addAuthorTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Action methods
    
    @IBAction func postButton(_ sender: Any) {
        
        // TODO: - Add functionality for posting a quote
        // TODO: - Check to see if quote is valid 

        
    }
  
    @IBAction func exitButton(_ sender: Any) {
            dismiss(animated: true, completion: nil)
    }
    
    

}
