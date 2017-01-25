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
        
      //  retrieveQuote()
      //  compareTime()
        
        
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
        //        quoteLabel.font = UIFont(name: SourceSansPro-Regular, size: 25)
        quoteLabel.sizeToFit()
        
        // Author Label
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
            //  hasSeenQuote(false)
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
        
        guard let userHasSeenQuote = defaults.object(forKey: "hasSeenQuote") as? Bool else { print("hasSeenQuote not found- byedefault"); return }
        
        print("-==-=-=-=- USER HAS SEEN QUOTE: \(userHasSeenQuote)-=-=-=-=-=-=")
        
        // Get value from user defaults
        guard let chosenTimeforDay = defaults.object(forKey: "chosenTime") as? Date else { print("CompareTime: byeDefault"); return }
        
        let chosenHour = Calendar.current.component(.hour, from: chosenTimeforDay)
        let chosenMin = Calendar.current.component(.minute, from: chosenTimeforDay)
        
        let currentHour = Calendar.current.component(.hour, from: currentDate)
        let currentMin = Calendar.current.component(.minute, from: currentDate)
        print("This is chosen time being set to stored default value: \(chosenTimeforDay)")
        
        // Compare dates
        // NOTE - Try comparing dates without the orderascending/descending
        
        if chosenTimeforDay.compare(currentDate) == .orderedAscending {
            print ("Chosen Date is earlier than currentDate")
            print("New TestDate is one step closer to displaying quote")
            
            if userHasSeenQuote {
                print("ORDER ASCENDING IF -- User has seen quote: Keep current Quote")
                hasSeenQuote(true)
            }
            else {
                print("ORDER ASCENDING ELSE -- User has not seen current quote: SHOW NEW QUOTE")

                showNewQuote()
                hasSeenQuote(true)
                
            }
            
            ////////////////////
//            if currentHour < chosenHour || currentHour == chosenHour && currentMin < chosenMin {
//                print("ORDER ASCENDING 1 -- Ehh, gotta wait a little longer")
//                hasSeenQuote(false)
//            }
//            else if userHasSeenQuote {
//                print("ORDER ASCENDING 2 -- User has seen quote: Keep current Quote")
//                hasSeenQuote(true)
//            }
//            else if currentHour > chosenHour && !userHasSeenQuote {
//                print("currentHour > chosenHour && !userHasSeenQuote")
//                print("ORDER ASCENDING 3 -- User has not seen current quote: SHOW NEW QUOTE")
//                showNewQuote()
//                hasSeenQuote(true)
//            }
//                
//                // These two else if statements may belong on their own:
//                // ie:chosenTimeforDay.compare(currentDate) == .orderedSame
//            else if currentHour == chosenHour && currentMin == chosenMin && !userHasSeenQuote {
//                print("currentHour == chosenHour && currentMin == chosenMin && !userHasSeenQuote")
//                print("ORDER ASCENDING 4 -- User has not seen current quote: SHOW NEW QUOTE")
//                showNewQuote()
//                hasSeenQuote(true)
//                
//            }
//            else if currentHour == chosenHour && currentMin > currentMin && !userHasSeenQuote {
//                print("currentHour == chosenHour && currentMin > currentMin && !userHasSeenQuote")
//                print("ORDER ASCENDING 5 -- User has not seen current quote: SHOW NEW QUOTE")
//                showNewQuote()
//                hasSeenQuote(true)
//                
//                
//            }
            
        }
            
        else if chosenTimeforDay.compare(currentDate) == .orderedDescending {
            print ("Chosen Time is later than currentDate's time")
            
            if chosenHour >= currentHour && chosenMin > currentMin {
                print("ORDER DESCENDING 1 -- Ehh, gotta wait a little longer")
                hasSeenQuote(false)
            }
        }
        else if chosenTimeforDay.compare(currentDate) == .orderedSame {
            print ("Chosen Time is equal to currentDate's time")

            
        }
        
        //        else if currentDate.compare(chosenTimeforDay) == .orderedSame {
        //            print("New TestDate is the same as Chosen Date")
        //            print("New TestDate is one step closer to displaying quote")
        //
        //            if (currentHour, currentMin) >= (chosenHour, chosenMin) {
        //                print("YES! SHOW QUOTE")
        //                showNewQuote()
        //            } else {
        //                print("Ehh, gotta wait a little longer")
        //            }
        //        }
        
        
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
    
    func hasSeenQuote(_ value: Bool = false) {
        
        defaults.set(value, forKey: "hasSeenQuote")
        print("USERDEFAULT: hasSeenQuote ----> \(value)")
        
    }
    
    
    
    
    
}

