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
    //   let chosenTimeforDay = Date()
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var gestureView: UIView!
    
    
    // MARK: - Action Methods
    
    @IBAction func favButton(_ sender: UIButton) {
        if sender.currentImage == #imageLiteral(resourceName: "Fill 71") {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
            UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6.0, options: .allowUserInteraction, animations: { [weak self] in sender.transform = .identity }, completion: nil)
            
            sender.setImage(#imageLiteral(resourceName: "Fill 71 Full"), for: .normal)
            
            guard let quote = quoteLabel.text else { print("no quote - leave favorites"); return }
            let author = authorLabel.text
            favoriteStore.saveToCoreDate(quote: quote, author: author)
            
        } else {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteQuote")
            
            for (index, value) in self.favoriteStore.favorites.enumerated() {
                
                guard let quote = quoteLabel.text else { print("no quote - leave favorites"); return }
                
                if quote == value.value(forKey: "quote") as! String {
                    context.delete(favoriteStore.favorites[index])
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                    
                    do {
                        self.favoriteStore.favorites = try context.fetch(fetchRequest)
                    } catch {
                        print("Fetching Failed")
                    }
                }
            }
            sender.setImage(#imageLiteral(resourceName: "Fill 71"), for: .normal)
        }
    }
    
    
    // TODO: - Add pan gesture
    func initializeGesture() {
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(recognizeLongPressGesture))
        gestureView.addGestureRecognizer(longPress)
        
    }
    
    func recognizeLongPressGesture() {
        
        print("Yes Yes I am being pressed")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.isHidden = true
        initializeGesture()
        // Notify when app becomes active
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive(_:)), name:NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
    }
    
    // MARK: - Notification Methods
    func applicationDidBecomeActive(_ notification: NSNotification) {
        retrieveQuote()
        compareTime()
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
    
    func retrieveQuote() {
        
        let quote = defaults.object(forKey: "quoteOfTheDay") as? String
        let author = defaults.object(forKey: "authorOfTheDay") as? String
        
        if quote == nil && author == nil {
            
            showNewQuote()
            
        } else {
            print("---Keep showing current quote--")
            configureViews()
        }
    }
    
    func showNewQuote() {
        
        self.store.getQuotes {
            print("GETTING CALLED")
            DispatchQueue.main.async {
                
                self.storeQuoteToUserDefaults()
                self.configureViews()
            }
        }
        
    }
    
    func compareTime() {
        let currentDate = Date()
        var timeManager = TimeManager()
        
        timeManager.compareTime(using: currentDate) {
            self.showNewQuote()
        }
        
        
    }
    
    
    // MARK:- User Default Methods
    
    func storeQuoteToUserDefaults() {
        
        guard let quote = store.quote?.quote else { print("leaving user defaults"); return }
        guard let author = store.quote?.author else { print("leaving user defaults"); return }
        
        defaults.set(quote, forKey: "quoteOfTheDay")
        defaults.set(author, forKey: "authorOfTheDay")
        
        guard let storedQuote = defaults.object(forKey: "quoteOfTheDay") as? String else { print("StoreQuote: byeDefault"); return }
        guard let storedAuthor = defaults.object(forKey: "authorOfTheDay") as? String else { print("StoreAuthor: byeDefault"); return }
        
        print("This is the quote default: \(storedQuote)")
        print("This is the author default: \(storedAuthor)")
        
    }
    
    
}

