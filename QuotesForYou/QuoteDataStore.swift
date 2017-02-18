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
    
   class func hasSeenQuote(_ value: Bool = false) {
        let defaults = UserDefaults.standard
        
        defaults.set(value, forKey: "hasSeenQuote")
        print("USERDEFAULT: hasSeenQuote ----> \(value)")
        
    }
    
}
