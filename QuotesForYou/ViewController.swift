//
//  ViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 12/29/16.
//  Copyright © 2016 Joyce Matos. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let store = QuoteDataStore.shared
    let favoriteStore = FavoritesDataStore.shared
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBAction func favoriteButton(_ sender: Any) {
        guard let quote = quoteLabel.text else { print("no quote - leave favorites"); return }
        let author = authorLabel.text
        save(quote: quote, author: author)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.store.getQuotes {
            print("GETTING CALLED")
            DispatchQueue.main.async {
                
                self.configureViews()
                
            }
        }
    }
    
    func configureViews() {

        // Quote Label
        quoteLabel.sizeToFit()
        guard let quote = store.quote?.quote else { print("no quote - leaving"); return }
        quoteLabel.text = quote
        
        // Author Label
        authorLabel.sizeToFit()
        guard let author = store.quote?.author else { print("no author - leaving"); return }
        authorLabel.text = author
    }
    
    func save(quote: String, author: String?) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteQuote", in: managedContext)!
        let quote = NSManagedObject(entity: entity, insertInto: managedContext)
        quote.setValue(quote, forKeyPath: "quote")
        quote.setValue(author, forKeyPath: "author")
        
        
        do {
            try managedContext.save()
            favoriteStore.favorites.append(quote)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

