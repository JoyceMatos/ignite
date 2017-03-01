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
    
    func favorite(quote: String, author: String?) {
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
    
    func unFavorite(selected quote: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteQuote")
        
        for (index, value) in favorites.enumerated() {
            
            if quote == value.value(forKey: "quote") as! String {
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
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteQuote")
        
        do {
            favorites = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deleteFavorite(quote: NSManagedObject) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteQuote")
        
        context.delete(quote)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        do {
            favorites = try context.fetch(fetchRequest)
        } catch {
            print("Fetching Failed")
        }
        
    }
    
    func shareFavorite(quote: NSManagedObject) -> [String] {

        let message = "Check out my quote of the day: "
        var shareArray = [String]()
        
        if let shareQuote = quote.value(forKey: "quote") as? String, let shareAuthor = quote.value(forKey: "author") as? String {
            
            shareArray.append(message)
            shareArray.append("\"\(shareQuote)\" - ")
            shareArray.append(shareAuthor)
        }
        return shareArray
    }
}
