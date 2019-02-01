//
//  BeerDetailViewController.swift
//  BeerMe
//
//  Created by Scarpz on 01/02/19.
//  Copyright © 2019 scarpz. All rights reserved.
//

import UIKit
import Nuke

class BeerDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var beerName: UILabel!
    @IBOutlet private weak var beerTagline: UILabel!
    @IBOutlet private weak var beerImage: UIImageView!
    @IBOutlet private weak var beerDescription: UILabel!
    @IBOutlet private weak var beerABV: UILabel!
    @IBOutlet private weak var beerIBU: UILabel!
    
    
    // MARK: - Properties
    var beer: Beer!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayBeer()
    }
    

    // MARK: - Actions
    @IBAction func shareBeer(_ sender: UIBarButtonItem) {
        
        var shareable = [Any]()
        
        if let image = self.beerImage.image {
            shareable.append(image)
        }
        
        shareable.append(ShareableHelper.shareableMessage(beer: self.beer))
        
        let shareAlert = UIActivityViewController(activityItems: shareable, applicationActivities: nil)
        self.present(shareAlert, animated: true, completion: nil)
    }
    
    
    // MARK: - Methods
    
    /// Display all the Beer information on the View
    private func displayBeer() {
        
        self.beerName.text = self.beer.name
        self.beerTagline.text = self.beer.tagline
        
        // Check a valid image URL based on the string value of the Beer
        if let url = URL(string: beer.imageURL) {
            // If yes, download this imagem and display in the ImageView
            loadImage(with: url, options: NukeOptions.imageLoading, into: self.beerImage)
        }
        
        self.beerDescription.text = self.beer.description
        
        self.beerABV.text = "\(self.beer.abv)%"
        self.beerIBU.text = "\(self.beer.ibu)%"
    }
}
