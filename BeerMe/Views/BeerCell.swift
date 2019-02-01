//
//  BeerCell.swift
//  BeerMe
//
//  Created by Scarpz on 01/02/19.
//  Copyright © 2019 scarpz. All rights reserved.
//

import UIKit
import Nuke

class BeerCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var beerName: UILabel!
    @IBOutlet private weak var beerAbv: UILabel!
    @IBOutlet private weak var beerImage: UIImageView!
    
    
    // MARK: - Methods
    func setup(beer: Beer) {
        self.beerName.text = beer.name
        self.beerAbv.text = "Abv: \(beer.abv)%"
        
        // Check a valid image URL based on the string value of the Beer
        if let url = URL(string: beer.imageURL) {
            // If yes, download this imagem and display in the ImageView
            loadImage(with: url, options: NukeOptions.imageLoading, into: self.beerImage)
        }
    }
}
