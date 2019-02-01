//
//  BeerDetailViewController.swift
//  BeerMe
//
//  Created by Scarpz on 01/02/19.
//  Copyright © 2019 scarpz. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {

    // MARK: - Outlets
    
    
    // MARK: - Properties
    var beer: Beer!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBeerDetailView()
    }
    

    // MARK: - Actions
    
    
    // MARK: - Methods
    private func setupBeerDetailView() {
        
        self.navigationItem.title = self.beer.name
    }
}
