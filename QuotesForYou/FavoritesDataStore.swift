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

final class FavoritesDataStore {
    
    static let shared = FavoritesDataStore()
    var favorites: [NSManagedObject] = []
    
    private init() { }
    
    func favorite(_ quote: String, author: String?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: CoreDataEntity.favoriteQuote, in: managedContext)!
        let favQuote = NSManagedObject(entity: entity, insertInto: managedContext)
        favQuote.setValue(quote, forKeyPath: CoreDataKey.quote)
        favQuote.setValue(author, forKey: CoreDataKey.author)
        
        do {
            try managedContext.save()
            favorites.append(favQuote)
            print("Saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func unFavorite(selected quote: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataEntity.favoriteQuote)
        
        for (index, value) in favorites.enumerated() {
            
            if quote == value.value(forKey: CoreDataKey.quote) as! String {
                context.delete(favorites[index])
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                do {
                    favorites = try context.fetch(fetchRequest)
                } catch {
                    print("Fetching Failed")
                }
            }
        }
        
    }
    
    func fetchFavorites() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataEntity.favoriteQuote)
        
        do {
            favorites = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deleteFavorite(_ quote: NSManagedObject) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataEntity.favoriteQuote)
        
        context.delete(quote)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        do {
            favorites = try context.fetch(fetchRequest)
        } catch {
            print("Fetching Failed")
        }
        
    }
    
    func shareFavorite(_ quote: NSManagedObject) -> [String] {
        let message = "Check out my quote of the day: "
        var shareArray = [String]()
        
        if let shareQuote = quote.value(forKey: CoreDataKey.quote) as? String, let shareAuthor = quote.value(forKey: CoreDataKey.author) as? String {
            
            shareArray.append(message)
            shareArray.append("\"\(shareQuote)\" - ")
            shareArray.append(shareAuthor)
        }
        return shareArray
    }
}
