//
//  ShareableHelper.swift
//  BeerMe
//
//  Created by Scarpz on 01/02/19.
//  Copyright © 2019 scarpz. All rights reserved.
//

import Foundation

class ShareableHelper {
    
    static func shareableMessage(beer: Beer) -> String{
        
        var message = ""
        
        message += "\(beer.name) | \(beer.tagline)\n\n"
        message += "ABV: \(beer.abv)%\n"
        message += "IBU: \(beer.ibu)%\n\n"
        message += "\(beer.description)"
        
        return message
    }
}
