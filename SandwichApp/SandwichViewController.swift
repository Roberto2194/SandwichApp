//
//  SandwichViewController.swift
//  SandwichApp
//
//  Created by Ivan Tilev on 29/02/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//
//MARK: THis is the ViewController that will be presented, when the user select a particular sandwich:

import UIKit

class SandwichViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var sandwichImageView: UIImageView!
    @IBOutlet weak var sandwichNameLabel: UILabel!
    @IBOutlet weak var IngredientLabel: UILabel!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favorite = false
    
    var sandwich: Sandwich!
    
    // Will hold the sandwich if the user press the Heart button
    var favoriteSndwich: [Sandwich] = []
    
    // Will check if the current Sandwich is favorite
    var isFavorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sandwichImageView.layer.cornerRadius = 10
        sandwichImageView.translatesAutoresizingMaskIntoConstraints = false
        setup()
    }
    
    func setup(){
        sandwichNameLabel.text = sandwich.name
        IngredientLabel.text = sandwich.ingredients
        sandwichImageView.image = UIImage(named: sandwich.img!)
        recipeLabel.text = sandwich.recipe
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // Favorite Button Pressed
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        favorite = !favorite
        if favorite {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            sandwich.favorite = true
            favoriteSndwich.append(sandwich)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            sandwich.favorite = false
            favoriteSndwich.removeLast()
        }
    }
    
}
