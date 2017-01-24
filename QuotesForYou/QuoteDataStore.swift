//
//  QuoteDataStore.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 12/30/16.
//  Copyright © 2016 Joyce Matos. All rights reserved.
//

import Foundation

class QuoteDataStore {
    
    static let shared = QuoteDataStore()
    var quote: Quote?
    
    func getQuotes(completion: @escaping () -> Void) {
        
        QuoteAPIClient.getQuotes { (randomQuote) in
            
            self.quote = Quote(dictionary: randomQuote)
            print(self.quote?.quote)
            completion()

        }
        
    }
    
//    func retrieveQuote() {
//        
//        let defaults = UserDefaults.standard
//        
//        let quote = defaults.object(forKey: "quoteOfTheDay") as? String
//        let author = defaults.object(forKey: "authorOfTheDay") as? String
//        
//        if quote == nil && author == nil {
//            
//            print("ShowNewQuote()")
//           // showNewQuote()
//            
//        } else {
//            print("---Keep showing current quote--")
//            //  hasSeenQuote(false)
//            print("configureViews()")
//
//          //  configureViews()
//            
//            print(quote)
//            print(author)
//        }
//        
//    }
//    
//    func compareTime() {
//        
//        let defaults = UserDefaults.standard
//        let currentDate = Date()
//        
//        //   ----------- TESTING WITH DUMMY CURRENT DATE ------------- \\
//        //                var testingCurrent = "08-01-2017 14:00"
//        //                let dateFormatter = DateFormatter()
//        //                dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
//        //                var currentDate = dateFormatter.date(from: testingCurrent)!
//        //                print("Test: \(currentDate)")
//        
//        // Testing with hasSeenBool
//        //  hasSeenQuote(false)
//        guard let userHasSeenQuote = defaults.object(forKey: "hasSeenQuote") as? Bool else { print("hasSeenQuote not found- byedefault"); return }
//        
//        print("-==-=-=-=- USER HAS SEEN QUOTE: \(userHasSeenQuote)-=-=-=-=-=-=")
//        
//        // Get value from user defaults
//        guard let chosenTimeforDay = defaults.object(forKey: "chosenTime") as? Date else { print("CompareTime: byeDefault"); return }
//        
//        let chosenHour = Calendar.current.component(.hour, from: chosenTimeforDay)
//        let chosenMin = Calendar.current.component(.minute, from: chosenTimeforDay)
//        
//        let currentHour = Calendar.current.component(.hour, from: currentDate)
//        let currentMin = Calendar.current.component(.minute, from: currentDate)
//        print("This is chosen time being set to stored default value: \(chosenTimeforDay)")
//        
//        // Compare dates
//        if chosenTimeforDay.compare(currentDate) == .orderedAscending {
//            print ("Chosen Date is earlier than currentDate")
//            print("New TestDate is one step closer to displaying quote")
//            
//            if currentHour < chosenHour {
//                print("ORDER ASCENDING -- Ehh, gotta wait a little longer")
//                hasSeenQuote(false)
//            }
//            else if userHasSeenQuote {
//                print("ORDER ASCENDING -- User has seen quote: Keep current Quote")
//                hasSeenQuote(true)
//            }
//            else if currentHour > chosenHour && !userHasSeenQuote {
//                print("currentHour > chosenHour && !userHasSeenQuote")
//                print("ORDER ASCENDING -- User has not seen current quote: SHOW NEW QUOTE")
//            //    showNewQuote()
//                print("ShowNewQuote")
//
//                hasSeenQuote(true)
//            }
//            else if currentHour == chosenHour && currentMin == chosenMin && !userHasSeenQuote {
//                print("currentHour == chosenHour && currentMin == chosenMin && !userHasSeenQuote")
//                print("ORDER ASCENDING -- User has not seen current quote: SHOW NEW QUOTE")
//             //   showNewQuote()
//                print("ShowNewQuote")
//
//                hasSeenQuote(true)
//                
//            }
//            else if currentHour == chosenHour && currentMin > currentMin && !userHasSeenQuote {
//                print("currentHour == chosenHour && currentMin > currentMin && !userHasSeenQuote")
//                print("ORDER ASCENDING -- User has not seen current quote: SHOW NEW QUOTE")
//              //  showNewQuote()
//                print("ShowNewQuote")
//
//                hasSeenQuote(true)
//                
//                
//            }
//            
//        }
//        
//        //        } else if currentDate.compare(chosenTimeforDay) == .orderedSame {
//        //            print("New TestDate is the same as Chosen Date")
//        //            print("New TestDate is one step closer to displaying quote")
//        //
//        //            if (currentHour, currentMin) >= (chosenHour, chosenMin) {
//        //                print("YES! SHOW QUOTE")
//        //                showNewQuote()
//        //            } else {
//        //                print("Ehh, gotta wait a little longer")
//        //            }
//        //        }
//        
//        
//        
//        
//        
//        
//    }
//    
//    func hasSeenQuote(_ value: Bool = false) {
//        let defaults = UserDefaults.standard
//        defaults.set(value, forKey: "hasSeenQuote")
//        print("USERDEFAULT: hasSeenQuote ----> \(value)")
//        
//    }
    
    
    
    
}
