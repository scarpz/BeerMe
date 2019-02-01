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
    // Beer info
    @IBOutlet private weak var beerName: UILabel!
    @IBOutlet private weak var beerAbv: UILabel!
    @IBOutlet private weak var beerImage: UIImageView!
    // Outter view to host de ImageView inside
    @IBOutlet private weak var outterView: UIView!
    
    
    // MARK: - Methods
    
    /// Setup all the information of the cell
    ///
    /// - Parameter beer: Beer to be displayed
    func setup(beer: Beer) {
        
        // Set the design of the OutterView
        self.outterView.layer.cornerRadius = 10
        
        // Till the text informations
        self.beerName.text = beer.name
        self.beerAbv.text = "Abv: \(beer.abv)%"
        
        // Check a valid image URL based on the string value of the Beer
        if let url = URL(string: beer.imageURL) {
            // If yes, download this imagem and display in the ImageView
            loadImage(with: url, options: NukeOptions.imageLoading, into: self.beerImage)
        }
    }
}
