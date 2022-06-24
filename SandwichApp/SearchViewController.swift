//
//  SearchViewController.swift
//  SandwichApp
//
//  Created by Ivan Tilev on 24/02/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//
//MARK: Search View Controller: Resposable for the Search screen of the tab bar:

import UIKit
import CoreData

class SearchViewController: UIViewController, UITableViewDelegate {
    
    // Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchIngredients: UISearchBar!
    @IBOutlet weak var currentCategory: UITextField!
    
    
    
    // The array with all the sandwiches got from the database
    var arraySandwich = CoreDataController.shared.loadAllSandwichs2()
    
    let secondVC = FavoritesViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundImageView.alpha = 0.1
        tableView.dataSource = self
        tableView.delegate = self
        self.searchIngredients.delegate = self
        
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    
    // Dismiss the keyboard when the "Search" button is pressed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    // get sandwiches by ingredients and/or category
        func getSandwiches()-> Array<Sandwich> {
            var newArray = [Sandwich]()
            guard !self.searchIngredients.text!.isEmpty else {return newArray}
            
            let ingredientsToSearch = self.searchIngredients.text!
            print(ingredientsToSearch)
    // if category is not used, use search function for all ingredients
            if self.currentCategory.text!.isEmpty {
                newArray = CoreDataController.shared.loadFromIngredients2(ingredient: ingredientsToSearch)
    // else use the search function in the choosed category of ingredients
            } else {
                newArray = CoreDataController.shared.loadFromIngredientsAndCategory2(ingredient: ingredientsToSearch, category: currentCategory.text!)
            }
            return newArray
        }
}

// MARK: - Table View Data Source
extension SearchViewController: UITableViewDataSource {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SendDataSegue" {
            
            let indexPaths = self.tableView!.indexPathsForSelectedRows!

            let indexPath = indexPaths[0] as NSIndexPath
            
            let vc = segue.destination as! SandwichViewController
            vc.modalPresentationStyle = .fullScreen
            vc.sandwich = arraySandwich[indexPath.row]
        }
    }
    
    // Pefrom the Segue bbased on the selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "SendDataSegue", sender: self)
    }
    
    // TableView: Numbers of the rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySandwich.count
    }
    
    // TableView: Configuring the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! CustomCell
                let currentLastItem = arraySandwich[indexPath.row]
                
                cell.sandwichNameLabel.text = currentLastItem.name
                cell.categoryLabel.text = String(" " + currentLastItem.category!)
                cell.imageCell.image = UIImage(named: currentLastItem.img!)
                cell.ingredientesLabel.text = currentLastItem.ingredients
                cell.imageCell.contentMode = .scaleAspectFit
                cell.layoutMargins = UIEdgeInsets.zero // remove table cell separator margin
                cell.contentView.layoutMargins.left = 20 // set up left margin to 20
                return cell
    }
}

// MARK: - Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        arraySandwich = getSandwiches()
        tableView.reloadData()
    }
}
