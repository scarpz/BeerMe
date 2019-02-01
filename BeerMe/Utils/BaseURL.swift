//
//  BaseURL.swift
//  BeerMe
//
//  Created by Scarpz on 01/02/19.
//  Copyright © 2019 scarpz. All rights reserved.
//

import Foundation

/// Struct to store all the URLs used in the application
struct BaseURL {
    static let getBeers = "https://api.punkapi.com/v2/beers?page={page}&per_page={per_page}"
    static let getBeerByName = "https://api.punkapi.com/v2/beers?beer_name={name}"
    static let getRandomBeer = "https://api.punkapi.com/v2/beers/random"
}
