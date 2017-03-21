//
//  PostViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 2/22/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    let firebaseManager = FirebaseManager.shared
    
    @IBOutlet weak var addQuoteTextView: UITextView!
    @IBOutlet weak var addAuthorTextField: UITextField!
    @IBOutlet weak var post: UIButton!
    @IBOutlet weak var cancel: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addQuoteTextView.delegate = self
        addAuthorTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Delegate methods
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        addQuoteTextView.text = nil
        addQuoteTextView.textColor = UIColor.orange
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addAuthorTextField.text = nil
        addAuthorTextField.textColor = UIColor.orange
        
    }
    

    // MARK: - Action methods
    
    @IBAction func postButton(_ sender: Any) {
        guard let quote = addQuoteTextView.text else { return }
        guard let author = addAuthorTextField.text else { return }
        
       // TODO: - Check to see if quote is valid
        
        firebaseManager.add(quote, author: author)
        dismiss(animated: true, completion: nil)

    }
  
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
 
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
