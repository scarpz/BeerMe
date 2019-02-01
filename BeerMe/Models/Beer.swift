//
//  Beer.swift
//  BeerMe
//
//  Created by Scarpz on 01/02/19.
//  Copyright © 2019 scarpz. All rights reserved.
//

import Foundation

struct Beer {
    var id: String
    var name: String
    var description: String
    var imageURL: String
    var tagline: String
    var abv: Double
    var ibu: Double
}

extension Beer {
    
    // Enum of keys from the response of the Request
    enum ResponseKeys: String, CodingKey {
        case id
        case name
        case description
        case imageURL = "image_url"
        case tagline
        case abv
        case ibu
    }
}

extension Beer {
    
    init(from decoder: Decoder) throws {
        
        // Get the container from the ResponseKeys
        let container = try decoder.container(keyedBy: ResponseKeys.self)
        
        // Try to get the values if present to each property
        let id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        let name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        let description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        let imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL) ?? ""
        let tagline = try container.decodeIfPresent(String.self, forKey: .tagline) ?? ""
        let abv = try container.decodeIfPresent(Double.self, forKey: .abv) ?? 0
        let ibu = try container.decodeIfPresent(Double.self, forKey: .ibu) ?? 0
        
        // And store them in your respective property
        self.id = id
        self.name = name
        self.description = description
        self.imageURL = imageURL
        self.tagline = tagline
        self.abv = abv
        self.ibu = ibu
    }
    
}
