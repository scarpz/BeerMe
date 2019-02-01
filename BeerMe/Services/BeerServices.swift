//
//  BeerServices.swift
//  BeerMe
//
//  Created by Scarpz on 01/02/19.
//  Copyright © 2019 scarpz. All rights reserved.
//

import Foundation

class BeerServices {
    
    /// Get all the Beers according the given parameter
    ///
    /// - Parameters:
    ///   - page: Page of the Beer Pagination
    ///   - amount: Amount of Beer per page
    ///   - completion: Returns an optional Beer list (if there is)
    ///                 or an optional Error, in case anything goes wrong
    static func getBeers(page: Int, amount: Int, completion: @escaping ([Beer]?, Error?) -> Void) {
        
        // Prepare the string valid of URL replacing the placeholder by the actial information
        var stringURL = BaseURL.getBeers.replacingOccurrences(of: "{page}", with: "\(page)")
        stringURL = stringURL.replacingOccurrences(of: "{per_page}", with: "\(amount)")
        
        // Check a valid URL based on the string value of Base URL
        if let url = URL(string: stringURL) {
            
            // Perform the Request
            Request.request(url: url, method: .get, headers: nil, body: nil) { data, error in
                
                // Check the nullability of data
                if let data = data {
                    
                    do {
                        // Decode data to Beer array
                        let beers = try JSONDecoder().decode([Beer].self, from: data)
                        
                        // Return the Beers
                        completion(beers, nil)
                        
                    } catch let error {
                        // Return an error if something goes wrong with the decode
                        completion(nil, error)
                    }
                } else {
                    // Returns an error from the HTTP Request
                    completion(nil, error)
                }
            }
        } else {
            // Returns an error if the string value of URL couldn't be converted to URL
            completion(nil, Errors.invalidURL)
        }
    }
    
    /// Gets a random Beer from the Server
    ///
    /// - Parameter completion: Returns an optional Beer (if there is)
    ///                         or an optional Error, in case anything goes wrong
    static func getRandomBeer(completion: @escaping (Beer?, Error?) -> Void) {
        
        // Check a valid URL based on the string value of Base URL
        if let url = URL(string: BaseURL.getRandomBeer) {
        
            // Perform the Request
            Request.request(url: url, method: .get, headers: nil, body: nil) { data, error in
                
                // Check the nullability of data
                if let data = data {
                    
                    do {
                        
                        // Decode data to Beer array (server returns an array)
                        let beers = try JSONDecoder().decode([Beer].self, from: data)
                        
                        // Gets the first value to return
                        if let beer = beers.first {
                            completion(beer, nil)
                        } else {
                            completion(nil, error)
                        }
                        
                    } catch let error {
                        // Return an error if something goes wrong with the decode
                        completion(nil, error)
                    }
                } else {
                    // Returns an error from the HTTP Request
                    completion(nil, error)
                }
            }
        } else {
            // Returns an error if the string value of URL couldn't be converted to URL
            completion(nil, Errors.invalidURL)
        }
    }
}
