//
//  RandomQuoteViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 2/7/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class RandomViewController: UIViewController {
    
    let store = QuoteDataStore.shared
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBAction func newQuoteButton(_ sender: Any) {
        self.store.getQuotes {
            print("GETTING CALLED")
            DispatchQueue.main.async {
                guard let quote = self.store.quote?.quote else { print("no quote to generate- bye"); return }
                guard let author = self.store.quote?.author else { print("no quote to generate- bye"); return }
                self.quoteLabel.text = quote
                self.authorLabel.text = author
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
