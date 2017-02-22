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
    
    func add(quote quote: String, author: String) {
        var feedRef = FIRDatabase.database().reference().child("newsfeed")
        
        let input = [
            "quote": quote,
            "author": author ]
        
        let itemRef = feedRef.childByAutoId()

        itemRef.setValue(input) { (error, ref) in
            
        }
  
    }
    
    
}
