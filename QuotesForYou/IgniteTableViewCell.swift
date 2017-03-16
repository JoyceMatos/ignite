//
//  igniteTableViewCell.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 2/22/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

protocol IgniteCellDelegate: class {
    func IgniteTableViewCell(_ sender: IgniteTableViewCell, didFlagQuote: Quote)
}

class IgniteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var delegate: IgniteCellDelegate?
    var quote: Quote! {
        didSet {
            quoteLabel.text = quote.quote?.description
            authorLabel.text = quote.author?.description
        }
    }
    
    let firebaseManager = FirebaseManager.shared
    let favoriteStore = FavoritesDataStore.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    // TODO: - Seperate logic; Add this functionality to a protocal or function
    @IBAction func favoriteTapped(_ sender: UIButton) {
        
        if sender.currentImage == #imageLiteral(resourceName: "Fill 71") {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
            UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6.0, options: .allowUserInteraction, animations: { [weak self] in sender.transform = .identity }, completion: nil)
            
            sender.setImage(#imageLiteral(resourceName: "Fill 71 Full"), for: .normal)
            
            guard let quoteText = quote.quote else { return }
            guard let authorText = quote.author else { return }
            
            favoriteStore.favorite(quote: quoteText, author: authorText)
            
        } else {
            guard let quoteText = quote.quote else { return }
            
            favoriteStore.unFavorite(selected: quoteText)
            sender.setImage(#imageLiteral(resourceName: "Fill 71"), for: .normal)
        }
        
    }
    
    
    @IBAction func flagTapped(_ sender: Any) {
        delegate = self
        DispatchQueue.main.async {
            self.delegate?.IgniteTableViewCell(self, didFlagQuote: self.quote)
        }
        
        //TODO: - Add alert to flag quote
    }
    
  
    
}

// MARK : - Delegate methods

extension IgniteTableViewCell: IgniteCellDelegate {
    
    func IgniteTableViewCell(_ sender: IgniteTableViewCell, didFlagQuote: Quote) {
        print("Right before flagging firebase")
        FirebaseManager.shared.flagQuote(didFlagQuote.quoteID.description)
    }
    
    
}
