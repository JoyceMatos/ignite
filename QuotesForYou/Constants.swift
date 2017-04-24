//
//  Constants.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 4/24/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation

struct QuoteAPI {
    
    static let baseURLString = "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json"
}

struct UserDefaultKey {
    
    static let quote = "quoteOfTheDay"
    static let author = "authorOfTheDay"
    static let chosenTime = "chosenTime"
    static let hasSeenQuote = "hasSeenQuote"
    
}

struct CoreDataEntity {
    
    static let favoriteQuote = "FavoriteQuote"
}

struct CoreDataKey {
    
    static let quote = "quote"
    static let author = "author"
    
}


struct SegueIdentifier {
    
    static let showTabBar = "showTabBar"
    
}

struct CellIdentifier {
    
    static let favoriteCell = "FavTableViewCell"
    static let igniteFeedCell = "IgniteTableViewCell"
    
}

struct FirebaseRef {
    
    static let newsfeed = "newsfeed"
    static let flag = "flag"
}
