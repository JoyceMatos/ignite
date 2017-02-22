//
//  igniteFeedViewController.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 2/22/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class igniteFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let igniteCell = igniteTableViewCell()
    var content = [Quote]()

    

    override func viewDidLoad() {
        super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 189
        
      // Dummy Data
        
        let quote1 = Quote(with: "Let the sun shine down and wash away our fears", author: "Some song")
        let quote2 = Quote(with: "I believe I believe I believe I believe I believe I believe I believe I believe I believe I believe I believe I believe I believe I believe", author: "Believer")
        let quote3 = Quote(with: "I get so weak in the knees I can hardly breathe I lose all control and something takes over me in a day --", author: "SWV")
        let quote4 = Quote(with: "I don't know what it is that you do to me, but it's a feeling that I want to stayayayayayayya", author: "SWV")

        content.append(quote1)
        content.append(quote2)
        content.append(quote3)
        content.append(quote4)

        
        
    }



}

extension igniteFeedViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quote = content[indexPath.row]
        let cell = Bundle.main.loadNibNamed("igniteTableViewCell", owner: self, options: nil)?.first as! igniteTableViewCell
        
        cell.quoteLabel.sizeToFit()
        cell.authorLabel.sizeToFit()
        cell.quoteLabel.text = quote.quote
        cell.authorLabel.text = quote.author
        
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

