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
    let currentDate = Date()
    let chosenTimeforDay = Date()
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBAction func favoriteButton(_ sender: Any) {
        guard let quote = quoteLabel.text else { print("no quote - leave favorites"); return }
        let author = authorLabel.text
        save(quote: quote, author: author)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        retrieveQuote()
        compareTime()

        
    }
    
    // MARK:- View Methods
    
    func configureViews() {

        guard let storedQuote = defaults.object(forKey: "quoteOfTheDay") as? String else { print("configureQuote: byeDefault"); return }
        guard let storedAuthor = defaults.object(forKey: "authorOfTheDay") as? String else { print("configureAuthor: byeDefault"); return }
        
        // Quote Label
     //   quoteLabel.sizeToFit()
//        guard let quote = store.quote?.quote else { print("no quote - leaving"); return }
        quoteLabel.text = storedQuote
//        quoteLabel.font = UIFont(name: SourceSansPro-Regular, size: 25)
        quoteLabel.sizeToFit()

        // Author Label
     //   authorLabel.sizeToFit()
//        guard let author = store.quote?.author else { print("no author - leaving"); return }
        authorLabel.text = storedAuthor
        authorLabel.sizeToFit()
    }
    
    // MARK:- Core Data Methods
    
    func save(quote: String, author: String?) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteQuote", in: managedContext)!
        let favQuote = NSManagedObject(entity: entity, insertInto: managedContext)
        favQuote.setValue(quote, forKeyPath: "quote")
        favQuote.setValue(author, forKey: "author")
        
        do {
            try managedContext.save()
            favoriteStore.favorites.append(favQuote)
            print("Saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
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
            
            print(quote)
            print(author)
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
        
      //   ----------- TESTING WITH DUMMY CURRENT DATE ------------- \\
//                var testingCurrent = "08-01-2017 14:00"
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
//                var currentDate = dateFormatter.date(from: testingCurrent)!
//                print("Test: \(currentDate)")
        
        // Get value from user defaults
        guard let chosenTimeforDay = defaults.object(forKey: "chosenTime") as? Date else { print("CompareTime: byeDefault"); return }
        
        let chosenHour = Calendar.current.component(.hour, from: chosenTimeforDay)
        let chosenMin = Calendar.current.component(.minute, from: chosenTimeforDay)
        
        let currentHour = Calendar.current.component(.hour, from: currentDate)
        let currentMin = Calendar.current.component(.minute, from: currentDate)
        print("This is chosen time being set to stored default value: \(chosenTimeforDay)")

        // Compare dates
        if chosenTimeforDay.compare(currentDate) == .orderedAscending {
            print ("Chosen Date is earlier than currentDate")
            
            if currentDate >= chosenTimeforDay {
                print("New TestDate is one step closer to displaying quote")
                if (currentHour, currentMin) >= (chosenHour, chosenMin) {
                    print("YES! SHOW QUOTE")
                    
                    // NOTE:- Prevent quote from showing twice after the time has passed
                    showNewQuote()
                } else {
                    print("Ehh, gotta wait a little longer")
                }
            }
            
        } else if currentDate.compare(chosenTimeforDay) == .orderedSame {
            print("New TestDate is the same as Chosen Date")
            print("New TestDate is one step closer to displaying quote")
            
            if (currentHour, currentMin) >= (chosenHour, chosenMin) {
                print("YES! SHOW QUOTE")
                showNewQuote()
            } else {
                print("Ehh, gotta wait a little longer")
            }
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

