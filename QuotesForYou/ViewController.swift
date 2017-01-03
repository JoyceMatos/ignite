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
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        QuoteAPIClient.getQuotes { (quote) in
//            print(quote)
//        }
        self.store.getQuotes {
            print("GETTING CALLED")
            DispatchQueue.main.async {

            self.configureViews()

        }
        }
        

    }
    
    func configureViews() {

        // Quote Label
        quoteLabel.sizeToFit()
        guard let quote = store.quote?.quote else { print("no quote - leaving"); return }
        quoteLabel.text = quote
        
        // Author Label
        authorLabel.sizeToFit()
        guard let author = store.quote?.author else { print("no author - leaving"); return }
        authorLabel.text = author
    }
}

