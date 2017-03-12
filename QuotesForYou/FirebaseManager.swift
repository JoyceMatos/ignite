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
        let feedRef = FIRDatabase.database().reference().child("newsfeed")
        
        let input = [
            "quote": quote,
            "author": author ]
        
        let itemRef = feedRef.childByAutoId()

        itemRef.setValue(input) { (error, ref) in
            
        }
  
    }
    
    func createQuote(completion:@escaping (String, String, String) -> Void) {
        let feedRef = FIRDatabase.database().reference().child("newsfeed").observe(.childAdded, with: { (snapshot) in
            
            let quoteDict = snapshot.value as! [String: Any]
            let quoteID = snapshot.key
            
            let quote = quoteDict["quote"] as! String
            let author = quoteDict["author"] as! String
            
            print("This is the snapshot key: \(snapshot.key)")
            print(quote)
            print(author)
            
            completion(quoteID, quote, author)
            
        })
    }
        
    func flagQuote(_ quoteID: String) {
        print("HELLO I AM IN FIREBASE")
        let flagRef = FIRDatabase.database().reference().child("flag")
        let flaggedQuote = [quoteID : true]
        
        flagRef.updateChildValues(flaggedQuote) { (error, ref) in
        }
        print("HELLO I HAVE FLAGGED IN FIREBASE")

        
    }
    
    
    
    
}
