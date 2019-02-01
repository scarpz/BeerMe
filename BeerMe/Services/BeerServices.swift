//
//  BeerServices.swift
//  BeerMe
//
//  Created by Scarpz on 01/02/19.
//  Copyright © 2019 scarpz. All rights reserved.
//

import Foundation

class BeerServices {
    
    static func getBeers(page: Int, completion: @escaping ([Beer]?, Error?) -> Void) {
        
        let stringURL = BaseURL.getBeers.replacingOccurrences(of: "{page}", with: "\(page)")
        
        if let url = URL(string: stringURL) {
            
            Request.request(url: url, method: .get, headers: nil, body: nil) { data, error in
                if let data = data {
                    
                    do {
                        let beers = try JSONDecoder().decode([Beer].self, from: data)
                        completion(beers, nil)
                        
                    } catch let error {
                        completion(nil, error)
                    }
                } else {
                    completion(nil, Errors.generic)
                }
            }
        } else {
            completion(nil, Errors.invalidURL)
        }
    }
    
}
