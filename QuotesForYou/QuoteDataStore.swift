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
    static let defaults = UserDefaults.standard
    
    
    func getQuotes(completion: @escaping () -> Void) {
        QuoteAPIClient.getQuotes { (randomQuote) in
            self.quote = Quote(dictionary: randomQuote)
            print(self.quote?.quote)
            completion()
        }
    }
    
   static func hasSeenQuote(_ value: Bool = false) {
        defaults.set(value, forKey: "hasSeenQuote")
        print("USERDEFAULT: hasSeenQuote ----> \(value)")
        
    }
    
    static func storeToUserDefaults(using currentQuote: String?, and currentAuthor: String?) {
        guard let quote = currentQuote else {
            print("leaving user defaults")
            return
        }
        
        guard let author = currentAuthor else {
            print("leaving user defaults")
            return
        }
        
        defaults.set(quote, forKey: "quoteOfTheDay")
        defaults.set(author, forKey: "authorOfTheDay")
        
        guard let storedQuote = defaults.object(forKey: "quoteOfTheDay") as? String else {
            return
        }
        
        guard let storedAuthor = defaults.object(forKey: "authorOfTheDay") as? String else {
            return
        }
        
    }
    
    static func retrieveQuote(with completion1: @escaping () -> Void, and completion2: @escaping () -> Void) {
        let quote = defaults.object(forKey: "quoteOfTheDay") as? String
        let author = defaults.object(forKey: "authorOfTheDay") as? String
        
        if quote == nil && author == nil {
            completion1()
        } else {
            completion2()
        }
    }
}


