//
//  ViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 12/29/16.
//  Copyright © 2016 Joyce Matos. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
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

        compareTime()
        retrieveQuote()
        
    }
    
    // MARK:- View Methods
    
    func configureViews() {

        guard let storedQuote = defaults.object(forKey: "quoteOfTheDay") as? String else { print("byeDefault"); return }
        guard let storedAuthor = defaults.object(forKey: "authorOfTheDay") as? String else { print("byeDefault"); return }
        
        // Quote Label
        quoteLabel.sizeToFit()
//        guard let quote = store.quote?.quote else { print("no quote - leaving"); return }
        quoteLabel.text = storedQuote
        
        // Author Label
        authorLabel.sizeToFit()
//        guard let author = store.quote?.author else { print("no author - leaving"); return }
        authorLabel.text = storedAuthor
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
    
    // MARK:- Actions 
    
    func retrieveQuote() {
        
        let quote = defaults.object(forKey: "quoteOfTheDay") as? String
        let author = defaults.object(forKey: "authorOfTheDay") as? String
        
        if quote == nil && author == nil {
            
            self.store.getQuotes {
                print("GETTING CALLED")
                DispatchQueue.main.async {
                    
                    self.storeQuoteToUserDefaults()
                    self.configureViews()
                }
            }
            
        } else {
            print("---Keep showing current quote")
            configureViews()
            
            print(quote)
            print(author)
        }

    }
    
    func compareTime() {
        
        // ----------- TESTING WITH DUMMY CURRENT DATE ------------- \\
        //        var testingCurrent = "07-01-2017 10:00"
        //        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        //        var currentDate = dateFormatter.date(from: testingCurrent)!
        //        print("Test: \(currentDate)")
        
        // Get value from user defaults
//        let defaults = UserDefaults.standard
        guard let chosenTimeforDay = defaults.object(forKey: "chosenTime") as? Date else { print("byeDefault"); return }
        
        print("This is chosen time being set to stored default value: \(chosenTimeforDay)")

        // Compare dates
        if chosenTimeforDay.compare(currentDate) == .orderedAscending {
            print ("Chosen Date is earlier than currentDate")
            
          //  var calculateChosen = Calendar.current.date(byAdding: .day, value: 1, to: chosenTimeforDay)
            
            if currentDate >= chosenTimeforDay {
                //  Eventually, these lines of code can be a protocol or extension
                
                print("New TestDate is one step closer to displaying quote")
                let chosenHour = Calendar.current.component(.hour, from: chosenTimeforDay)
                let chosenMin = Calendar.current.component(.minute, from: chosenTimeforDay)
                
                let currentHour = Calendar.current.component(.hour, from: currentDate)
                let currentMin = Calendar.current.component(.minute, from: currentDate)
                
                if (currentHour, currentMin) >= (chosenHour, chosenMin) {
                    print("YES! SHOW QUOTE")
                } else {
                    print("Ehh, gotta wait a little longer")
                }
            }
            
        } else if currentDate.compare(chosenTimeforDay) == .orderedSame {
            print("New TestDate is the same as Chosen Date")
            print("New TestDate is one step closer to displaying quote")
            let chosenHour = Calendar.current.component(.hour, from: chosenTimeforDay)
            let chosenMin = Calendar.current.component(.minute, from: chosenTimeforDay)
            
            let currentHour = Calendar.current.component(.hour, from: currentDate)
            let currentMin = Calendar.current.component(.minute, from: currentDate)
            
            if (currentHour, currentMin) >= (chosenHour, chosenMin) {
                print("YES! SHOW QUOTE")
            } else {
                print("Ehh, gotta wait a little longer")
            }
        }
    }
    
    // MARK:- User Default Methods
    
    func storeQuoteToUserDefaults() {
        
        // This gets repeated multiple times (refactos
        guard let quote = store.quote?.quote else { print("leaving user defaults"); return }
        guard let author = store.quote?.author else { print("leaving user defaults"); return }

        
        defaults.set(quote, forKey: "quoteOfTheDay")
        defaults.set(author, forKey: "authorOfTheDay")
        
        
        guard let storedQuote = defaults.object(forKey: "quoteOfTheDay") as? String else { print("byeDefault"); return }
        guard let storedAuthor = defaults.object(forKey: "authorOfTheDay") as? String else { print("byeDefault"); return }
        
        
        print("This is the quote default: \(storedQuote)")
        print("This is the author default: \(storedAuthor)")
        
    }
    
    
    
    
    
}

