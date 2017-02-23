//
//  PostViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 2/22/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    let firebaseManager = FirebaseManager.shared
    
    @IBOutlet weak var addQuoteTextView: UITextView!
    @IBOutlet weak var addAuthorTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Action methods
    
    @IBAction func postButton(_ sender: Any) {
        guard let quote = addQuoteTextView.text else { return }
        guard let author = addAuthorTextField.text else { return }
        
       // TODO: - Check to see if quote is valid
        
        firebaseManager.add(quote: quote, author: author)
    }
  
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    
    

}
