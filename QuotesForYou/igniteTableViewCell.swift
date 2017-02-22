//
//  igniteTableViewCell.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 2/22/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class igniteTableViewCell: UITableViewCell {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        
        if sender.currentImage == #imageLiteral(resourceName: "Fill 71") {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
            UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6.0, options: .allowUserInteraction, animations: { [weak self] in sender.transform = .identity }, completion: nil)
            
            sender.setImage(#imageLiteral(resourceName: "Fill 71 Full"), for: .normal)
            
            guard let quote = quoteLabel.text else { print("no quote - leave favorites"); return }
            let author = authorLabel.text
            
            // TODO: Figure out how to store to favorite
            
          //  favoriteStore.favorite(quote: quote, author: author)
            
        } else {
            guard let quote = quoteLabel.text else { print("no quote - leave favorites"); return }
            
            // TODO: Figure out how to store to favorite

            
         //   favoriteStore.unFavorite(selected: quote)
            sender.setImage(#imageLiteral(resourceName: "Fill 71"), for: .normal)
        }
 
        
    }
    
    
}
