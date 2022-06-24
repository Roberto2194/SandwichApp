//
//  FavoritesViewController.swift
//  SandwichApp
//
//  Created by Ivan Tilev on 24/02/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//
// Favorites View Controller: Show the user all the Favorite sandwiches, picked by him

import UIKit
import CoreData


class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - CoreData: Logic to add sanwiches to the database
    @IBOutlet weak var fieldName: UITextField!
    @IBOutlet weak var fieldIngredients: UITextField!
    @IBOutlet weak var fieldRecipe: UITextField!
    @IBOutlet weak var fieldCategory: UITextField!
    @IBOutlet weak var fieldImg: UITextField!
    
    //MARK: Outlers regarding the actual Favorites sceen
    @IBOutlet weak var tableView: UITableView!
    
    // Saving Sandwich to CoreData
    @IBAction func saveSandwich_clicked(_ sender: UIButton) {
        
        guard !self.fieldName.text!.isEmpty else {return}
        guard !self.fieldIngredients.text!.isEmpty else {return}
        guard !self.fieldRecipe.text!.isEmpty else {return}
        guard !self.fieldCategory.text!.isEmpty else {return}
        guard !self.fieldImg.text!.isEmpty else {return}
        
        let name = self.fieldName.text!
        let ingredients = self.fieldIngredients.text!
        let recipe = self.fieldRecipe.text!
        let category = self.fieldCategory.text!
        let img = self.fieldImg.text!
        
        CoreDataController.shared.addSandwich(name: name, ingredients: ingredients, recipe: recipe, category: category, img: img)
        
    }
    
    //MARK: Handeling the actual Favorite screen
    
    // The array of favorite sandwiches
    var allSandwicheZ: [Sandwich] = CoreDataController.shared.loadAllSandwichs2()
    
    var favoriteSndwiches: [Sandwich] = []
    
    let userdefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    
    // Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allSandwicheZ.count
    }
    
    // Cell for Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! CustomCell
        
        for sandwich in allSandwicheZ {
            if sandwich.favorite == true {
                favoriteSndwiches.append(sandwich)
            } else {
                
            }
        }
        
        if favoriteSndwiches.isEmpty {
            cell.imageCell.image = UIImage(named: "search_pic")
            cell.sandwichNameLabel.text = "Add favorite sandwich"
            cell.categoryLabel.text = " and it will appear here..."
            cell.ingredientesLabel.text = "and we will save it for you"
        } else {
            cell.imageCell.image = UIImage(named: favoriteSndwiches[indexPath.row].img!)
            cell.sandwichNameLabel.text = favoriteSndwiches[indexPath.row].name
            cell.categoryLabel.text = favoriteSndwiches[indexPath.row].category
            cell.ingredientesLabel.text = favoriteSndwiches[indexPath.row].ingredients
        }
        
        return cell
    }
    
//    // Did Select a Cell
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "favoriteToDetails", sender: self)
//    }
    
}
