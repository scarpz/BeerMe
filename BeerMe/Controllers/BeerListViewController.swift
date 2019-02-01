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
    // TableView to display the Beer List
    @IBOutlet private weak var tableView: UITableView!
    
    
    // MARK: - Properties
    // Refresh for the TableView
    private let refreshControl = UIRefreshControl()
    // Lsit of Beers to be displayed
    private var beers = [Beer]()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBeerListView()
        self.getBeers()
    }
    
    
    // MARK: - Methods
    
    /// Setup all the information needed for this View to work property as needed
    private func setupBeerListView() {
        
        // Set the Delegate and Datasource of the TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Add an action to the refresh interaction
        self.refreshControl.addTarget(self, action: #selector(getBeers), for: .valueChanged)
        
        // Insert the refresh control in the TableView
        self.tableView.refreshControl = refreshControl
    }
    
    /// Method responsible to retrieve all the Beers from server
    @objc private func getBeers() {
        
        // Perform the request itself
        BeerServices.getBeers(page: 1, amount: 25) { beers, error in
            
            // Check the nullability of the Beers
            if let beers = beers {
                // Set the beers property used as TableView Datasource
                self.beers = beers
                
                // Reload the TableView (in the main thread)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                // If the Beers from server is nil, display an Alert with the error
                // and suggest the User to try again
                DispatchQueue.main.async {
                    self.createAlert(title: "Oops...", message: "\(error?.localizedDescription ?? "An error has occurred. Try again.")", okButton: "Try Again", okAction: { _ in
                        self.getBeers()
                    }, cancelButton: "Cancel")
                }
            }
        }
    }
    
    /// Method responsible to retrieve a random Beer from server
    private func getRandomBeer() {
        
        // Display an Alert to show the user there is a request going on
        let alert = UIAlertController(title: "Loading a random Beer", message: nil, preferredStyle: .alert)
        self.present(alert, animated: true) {
            
            // Perform the request itself
            BeerServices.getRandomBeer(completion: { randomBeer, error in
                
                // Check the nullability of the random Beers
                if let randomBeer = randomBeer {
                    
                    // Dismiss the alert and goes to the detail od the retrieve Beer
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                        self.performSegue(withIdentifier: "BeerDetailSegue", sender: randomBeer)
                    }
                } else {
                    // If the Beers from server is nil, display an Alert with the error
                    // and suggest the User to try again
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                        self.createAlert(title: "Oops...", message: "\(error?.localizedDescription ?? "An error has occurred. Try again.")")
                    }
                }
            })
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BeerDetailSegue" {
            if let selectedBeer = sender as? Beer {
                if let beerDetailVC = segue.destination as? BeerDetailViewController {
                    beerDetailVC.beer = selectedBeer
                }
            }
        }
    }
    
}


// MARK: - TableView Methos
extension BeerListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.beers.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Random Beer Cell
        if indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "RandomBeerCell") ?? UITableViewCell()
        } else {
            // Beers already loaded from server Cells
            if let cell = tableView.dequeueReusableCell(withIdentifier: "BeerCell") as? BeerCell {
                cell.setup(beer: self.beers[indexPath.row - 1])
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Loads a random Beer
        if indexPath.row == 0 {
            self.getRandomBeer()
        } else {
            // Gets the selected Beer to display its details
            self.performSegue(withIdentifier: "BeerDetailSegue", sender: self.beers[indexPath.row - 1])
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
