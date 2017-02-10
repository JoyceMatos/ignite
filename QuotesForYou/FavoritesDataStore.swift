//
//  FavoriteQuote.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 1/3/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class FavoritesDataStore {
    
    static let shared = FavoritesDataStore()
    var favorites: [NSManagedObject] = []
    
    private init() { }
    
    func saveToCoreDate(quote: String, author: String?) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteQuote", in: managedContext)!
        let favQuote = NSManagedObject(entity: entity, insertInto: managedContext)
        favQuote.setValue(quote, forKeyPath: "quote")
        favQuote.setValue(author, forKey: "author")
        
        do {
            try managedContext.save()
            favorites.append(favQuote)
            print("Saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    

    
}
