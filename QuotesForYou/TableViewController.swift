//
//  TableViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 1/3/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    let store = FavoritesDataStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 189

    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteQuote")
        
        do {
            store.favorites = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.favorites.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quote = store.favorites[indexPath.row]

        let cell = Bundle.main.loadNibNamed("TableViewCell1", owner: self, options: nil)?.first as! TableViewCell1
        cell.quoteLabel.sizeToFit()
        cell.authorLabel.sizeToFit()
        cell.quoteLabel.text = quote.value(forKey: "quote") as? String
        cell.authorLabel.text = quote.value(forKey: "author") as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 189
    }
 
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            print("********** The delete button is tapped ********** ")
            
            // TODO: - Refactor             
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteQuote")
            
            let quote = self.store.favorites[indexPath.row]
            context.delete(quote)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                self.store.favorites = try context.fetch(fetchRequest)
            } catch {
                print("Fetching Failed")
            }
            
            // TODO: - Add Notification once it's been deleted (feedback)

            
            tableView.reloadData()
  
            
        }
        
        let share = UITableViewRowAction(style: .normal, title: "Share") { (action, indexPath) in

            let quote = self.store.favorites[indexPath.row]
            let message = "Check out my quote of the day: "
            guard let shareQuote = quote.value(forKey: "quote") as? String else { print("leaveActivity- no quote"); return }
            guard let shareAuthor = quote.value(forKey: "author") as? String else { print("leaveActivity- no author"); return }
            
            var shareArray = [String]()

            shareArray.append(message)
            shareArray.append("\"\(shareQuote)\" - ")
            shareArray.append(shareAuthor)

            let activityVC = UIActivityViewController(activityItems: shareArray, applicationActivities: nil)
                        
            //TODO: - This is for ipads, must adjust
            if let popoverController = activityVC.popoverPresentationController {
                popoverController.sourceView = self.view as? UIView
                popoverController.sourceRect = self.view.bounds
                
                self.present(activityVC, animated: true, completion: nil)
            }
        }
    
        return [delete, share]
    }


    
}
