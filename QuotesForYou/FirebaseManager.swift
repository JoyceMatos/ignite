//
//  FirebaseManager.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 2/22/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class FirebaseManager {
    
    static let shared = FirebaseManager()
    var ref: FIRDatabaseReference!
    
    
    private init() {}
    
    func add(_ quote: String, author: String?) {
        var feedRef = FIRDatabase.database().reference().child("newsfeed")
        
        let input = [
            "quote": quote,
            "author": author ]
        
        let itemRef = feedRef.childByAutoId()

        itemRef.setValue(input) { (error, ref) in
            
        }
  
    }
    
    func createQuote() {
        
        let feedRef = FIRDatabase.database().reference().child("newsfeed").observe(.childAdded, with: { (snapshot) in
            
         // TODO: - get dictionary values 
            
        let quoteDict = snapshot.value as! [String: Any]
            
        let quote = quoteDict["quote"]
        let author = quoteDict["author"]
            print(quote)
            print(author)

            
        })
        
        
    }
        
    func flagQuote(with quoteID: String) {
        let flagRef = FIRDatabase.database().reference().child("flag")
        let flaggedQuote = [quoteID : true]
        
        flagRef.setValue(flaggedQuote) { (error, ref) in
        }
        
    }
    
    
    
    
}
