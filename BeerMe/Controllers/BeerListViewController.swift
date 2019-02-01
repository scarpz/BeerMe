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
    
    private func getRandomBeer() {
        
        let alert = UIAlertController(title: "Loading a random Beer", message: nil, preferredStyle: .alert)
        self.present(alert, animated: true) {
            
            BeerServices.getRandomBeer(completion: { randomBeer, error in
                if let randomBeer = randomBeer {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                        self.performSegue(withIdentifier: "BeerDetailSegue", sender: randomBeer)
                    }
                } else {
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
        return self.allBeers.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "RandomBeerCell") ?? UITableViewCell()
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "BeerCell") as? BeerCell {
                cell.setup(beer: self.allBeers[indexPath.row - 1])
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            self.getRandomBeer()
        } else {
            self.performSegue(withIdentifier: "BeerDetailSegue", sender: self.allBeers[indexPath.row - 1])
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
