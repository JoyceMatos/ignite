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
        
        configureViews()

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
        let cell = Bundle.main.loadNibNamed("FavTableViewCell", owner: self, options: nil)?.first as! FavTableViewCell
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

            self.store.deleteFavorite(quote)
            
            tableView.reloadData()
  
        }
        
        let share = UITableViewRowAction(style: .normal, title: "Share") { (action, indexPath) in
            let quote = self.store.favorites[indexPath.row]
            let shareArray = self.store.shareFavorite(quote)
            
            self.addActivityVC(with: shareArray)
            
        }
        return [delete, share]
    }
    
    // MARK: - View methods
    
    func configureViews() {
        // TableView Height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 189
        
        // TabBar Height
        let tabBarHeight = self.tabBarController?.tabBar.bounds.height
        self.edgesForExtendedLayout = UIRectEdge.all
        self.tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: tabBarHeight!, right: 0.0)
    
    }

    // MARK: - Helper methods

    func addActivityVC(with shareArray: [String]) {
        let activityVC = UIActivityViewController(activityItems: shareArray, applicationActivities: nil)
        
        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceView = self.view as UIView
            popoverController.sourceRect = self.view.bounds
            
            self.present(activityVC, animated: true, completion: nil)
        }
    }

}
