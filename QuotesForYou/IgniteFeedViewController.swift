//
//  igniteFeedViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 2/22/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit


class IgniteFeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let igniteCell = IgniteTableViewCell()
    let firebaseManager = FirebaseManager.shared
    var content = [Quote]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        firebaseManager.createQuote { (quoteID, quote, author) in
            let quote = Quote(with: quoteID, quote: quote, author: author)
            self.content.insert(quote, at: 0)
            
            self.tableView.reloadData()
            
        }
        
        tableView.reloadData()
        
    }
    
    func configureViews() {
        // TableView Height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 189
        
        // TabBar Height
        let tabBarHeight = self.tabBarController?.tabBar.bounds.height
        self.edgesForExtendedLayout = UIRectEdge.all
        self.tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: tabBarHeight!, right: 0.0)

    }
    
    
}

// MARK:- TableView methods

extension IgniteFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quote = content[indexPath.row]
        let cell = Bundle.main.loadNibNamed(CellIdentifier.igniteFeedCell, owner: self, options: nil)?.first as! IgniteTableViewCell
        
        cell.flagDelegate = self
        cell.quote = quote
        cell.quoteLabel.sizeToFit()
        cell.authorLabel.sizeToFit()
        cell.quoteLabel.text = cell.quote.quote?.description
        cell.authorLabel.text = cell.quote.author?.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}

extension IgniteFeedViewController: FlagNotification {
    
    func sendAlert(completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: "Report", message: "Are you sure you want to report this quote?" , preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (UIAlertAction) in
            print("OK Pressed")
            completion()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}


