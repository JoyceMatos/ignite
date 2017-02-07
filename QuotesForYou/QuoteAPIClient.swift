//
//  QuoteAPIClient.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 12/29/16.
//  Copyright © 2016 Joyce Matos. All rights reserved.
//

import Foundation

class QuoteAPIClient {
    
    class func getQuotes(completion: @escaping ([String : String]) -> Void) {
        let urlString = "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json"
        guard let url = URL(string: urlString) else { print("no url- leaving function"); return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { print("Unable to get data: \(error?.localizedDescription)"); return }
            if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : String] {
                if let responseJSON = responseJSON {
                    completion(responseJSON)
                }
            }
        }
        task.resume()
    }
}
