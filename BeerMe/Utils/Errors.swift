//
//  Errors.swift
//  BeerMe
//
//  Created by Scarpz on 01/02/19.
//  Copyright © 2019 scarpz. All rights reserved.
//

import Foundation

/// Errors for a better accuracy to debug
///
/// - invalidURL: Used when the String couldn't be converted to URL
/// - generic: Generic Error
/// - noBeers: There is no Beer in the response
enum Errors: Error {
    case invalidURL
    case generic
    case noBeers
}
