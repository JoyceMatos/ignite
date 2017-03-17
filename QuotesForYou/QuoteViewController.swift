//
//  ViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 12/29/16.
//  Copyright © 2016 Joyce Matos. All rights reserved.
//

import UIKit
import CoreData

class QuoteViewController: UIViewController {
    
    let store = QuoteDataStore.shared
    let favoriteStore = FavoritesDataStore.shared
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var gestureView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeGesture()
        beginToObserve()
    }
    
    // MARK: - Notification Methods
    
    func applicationDidBecomeActive(_ notification: NSNotification) {
        QuoteDataStore.retrieveQuote(with: {
            self.showNewQuote()
        }) {
            self.configureViews()
        }
        compareTime()
    }
    
    func beginToObserve() {

        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive(_:)), name:NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    // MARK: - Action Methods
    
    @IBAction func favButton(_ sender: UIButton) {
        if sender.currentImage == #imageLiteral(resourceName: "Fill 71") {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
            UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6.0, options: .allowUserInteraction, animations: { [weak self] in sender.transform = .identity }, completion: nil)
            
            sender.setImage(#imageLiteral(resourceName: "Fill 71 Full"), for: .normal)
            
            guard let quote = quoteLabel.text else { print("no quote - leave favorites"); return }
            let author = authorLabel.text
            favoriteStore.favorite(quote: quote, author: author)
            
        } else {
            guard let quote = quoteLabel.text else { print("no quote - leave favorites"); return }
            
            favoriteStore.unFavorite(selected: quote)
            sender.setImage(#imageLiteral(resourceName: "Fill 71"), for: .normal)
        }
    }
    
    // MARK:- View Methods
    
    func configureViews() {
        guard let storedQuote = defaults.object(forKey: "quoteOfTheDay") as? String else { print("configureQuote: byeDefault"); return }
        guard let storedAuthor = defaults.object(forKey: "authorOfTheDay") as? String else { print("configureAuthor: byeDefault"); return }
        
        // Quote Label
        quoteLabel.text = storedQuote
        quoteLabel.sizeToFit()
        
        // Author Label
        authorLabel.text = storedAuthor
        authorLabel.sizeToFit()
    }
    
    // MARK:- Helper Methods
    
    func showNewQuote() {
        self.store.getQuotes {
            DispatchQueue.main.async {
                QuoteDataStore.storeQuoteToUserDefaults(using: self.store.quote?.quote, and: self.store.quote?.author)
                self.configureViews()
                QuoteDataStore.hasSeenQuote(true)
            }
        }
    }
    
    func compareTime() {
        let currentDate = Date()
        let timeManager = TimeManager()
        
        timeManager.compareTime(using: currentDate) {
            self.showNewQuote()
        }
    }

}


