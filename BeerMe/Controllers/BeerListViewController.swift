//
//  BeerListViewController.swift
//  BeerMe
//
//  Created by Scarpz on 01/02/19.
//  Copyright © 2019 scarpz. All rights reserved.
//

import UIKit

class BeerListViewController: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    
    // MARK: - Properties
    private let cellIdentifiers = ["RandomBeerCell", "BeerCell"]
    private var allBeers = [Beer]()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBeerListView()
        self.getBeers()
    }
    
    
    // MARK: - Methods
    
    /// Setup all the information needed for this View to work property as needed
    private func setupBeerListView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func getBeers() {
        
        BeerServices.getBeers(page: 1) { beers, error in
            
            if let beers = beers {
                self.allBeers = beers
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.createAlert(title: "Oops...", message: "\(error?.localizedDescription ?? "An error has occurred. Try again.")", okButton: "Try Again", okAction: { _ in
                        self.getBeers()
                    }, cancelButton: "Cancel")
                }
            }
        }
    }
    
    // MARK: - Navigation

}


// MARK: - TableView Methos
extension BeerListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.allBeers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifiers[indexPath.section]) {
            
            if indexPath.section == 0 {
                return cell
            } else {
                if let beerCell = cell as? BeerCell {
                    beerCell.setup(beer: self.allBeers[indexPath.row])
                    return beerCell
                } else {
                    return UITableViewCell()
                }
            }
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
