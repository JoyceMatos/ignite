//
//  Quote.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 12/29/16.
//  Copyright © 2016 Joyce Matos. All rights reserved.
//

import Foundation

class Quote {
    
    var quote: String?
    var author: String?
    
    init(dictionary: [String : String]) {
        
        if let quote = dictionary["quoteText"], let author = dictionary["quoteAuthor"], let link = dictionary["quoteLink"] {
        self.quote = quote
        self.author = author
        }
    }
    
    init(with quote: String, author: String) {
        
        self.quote = quote
        self.author = author
        
    }
 
}
