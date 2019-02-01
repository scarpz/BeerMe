//
//  Request.swift
//  BeerMe
//
//  Created by Scarpz on 01/02/19.
//  Copyright © 2019 scarpz. All rights reserved.
//

import Foundation

class Request {
    
    /// Method responsible to perform a HTTP request based on given information
    ///
    /// - Parameters:
    ///   - url: URL to try to access
    ///   - method: Method of the request
    ///   - headers: Headers of the request, if existing
    ///   - body: Body of the request, if existing
    ///   - completion: Dictionary of the response received from the request
    static func request(url: URL, method: RequestMethod, headers: [String : String]?, body: Data?, completion: @escaping (_ response: Data?, _ error: Error?) -> Void) {
        
        // Creates a Requesr
        var request = URLRequest(url: url)
        
        // Fills the request information
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.allHTTPHeaderFields = headers
        
        // Performs the task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Check the nullability of data or return the error
            if let data = data {
                completion(data, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
}
