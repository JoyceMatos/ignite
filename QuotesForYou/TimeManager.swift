//
//  TimeManager.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 2/17/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

class TimeManager {
    
    func compareTime(using currentDate: Date, completion: @escaping () -> Void) {
        let defaults = UserDefaults.standard
        
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
        // NOTE - Works but is a little delayed by the seconds
        
        if chosenTimeforDay.compare(currentDate) == .orderedAscending {
            
            if userHasSeenQuote {
                QuoteDataStore.hasSeenQuote(true)
                
            } else if chosenHour == currentHour && chosenMin == currentMin && !userHasSeenQuote {
                completion()
                QuoteDataStore.hasSeenQuote(true)
                
                
            } else if chosenHour == currentHour && chosenMin < currentMin && !userHasSeenQuote {
                completion()
                QuoteDataStore.hasSeenQuote(true)
                
                
            } else if chosenHour < currentHour && !userHasSeenQuote {
                completion()
                QuoteDataStore.hasSeenQuote(true)
                
            }
            
        } else if chosenTimeforDay.compare(currentDate) == .orderedDescending {
            
            if chosenHour == currentHour && chosenMin == currentMin && !userHasSeenQuote {
                completion()
                QuoteDataStore.hasSeenQuote(true)
                
            } else if chosenHour == currentHour && chosenMin > currentMin {
                QuoteDataStore.hasSeenQuote(false)
                
                
            } else if chosenHour > currentHour {
                QuoteDataStore.hasSeenQuote(false)
                
            }
            
        } else if chosenTimeforDay.compare(currentDate) == .orderedSame {
            completion()
            QuoteDataStore.hasSeenQuote(true)
        }
        
    }
    
    
    
}
