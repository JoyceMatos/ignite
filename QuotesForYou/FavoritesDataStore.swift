//
//  FavoriteQuote.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 1/3/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation
import CoreData

class FavoritesDataStore {
    
    static let shared = FavoritesDataStore()
    var favorites: [NSManagedObject] = []
    
    private init() { }
    
}
