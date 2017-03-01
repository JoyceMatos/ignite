//
//  TableViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 1/3/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit
import CoreData

class FavoriteTableViewController: UITableViewController {

    let store = FavoritesDataStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 189

    }
    
    override func viewDidAppear(_ animated: Bool) {
        store.fetchFavorites()
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
            let quote = self.store.favorites[indexPath.row]

            self.store.deleteFavorite(quote: quote)
            
            // TODO: - Add Notification once it's been deleted (feedback)

            tableView.reloadData()
  
        }
        
        let share = UITableViewRowAction(style: .normal, title: "Share") { (action, indexPath) in
            let quote = self.store.favorites[indexPath.row]
            var shareArray = self.store.shareFavorite(quote: quote)
            
            self.addActivityVC(with: shareArray)
            
        }
        return [delete, share]
    }

    // MARK: - Helper methods

    func addActivityVC(with shareArray: [String]) {
        let activityVC = UIActivityViewController(activityItems: shareArray, applicationActivities: nil)
        
        //TODO: - This is for ipads
        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceView = self.view as? UIView
            popoverController.sourceRect = self.view.bounds
            
            self.present(activityVC, animated: true, completion: nil)
        }
    }

}
