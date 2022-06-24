//
//  ViewController.swift
//  SandwichApp
//
//  Created by Ivan Tilev on 24/02/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//
// MARK: - Categories View Controller: Fist screen of the app, that will contain all the categories:

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
     var sandwiches = CoreDataController.shared.loadAllSandwichs2()
    
     var vegan = CoreDataController.shared.loadFromIngredientsAndCategory2(ingredient: ",", category: "Vegan")
    
     var vegetarian = CoreDataController.shared.loadFromIngredientsAndCategory2(ingredient: ",", category: "Vegetarian")
    
     var celiac = CoreDataController.shared.loadFromIngredientsAndCategory2(ingredient: ";", category: "Celiacs")
    
     var diabetics = CoreDataController.shared.loadFromIngredientsAndCategory2(ingredient: ",", category: "Diabetics")
    
     var worldClaasics = CoreDataController.shared.loadFromIngredientsAndCategory2(ingredient: ",", category: "Worldwide Classics")
    
     var selectedCategory = [Sandwich]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 20
        
        tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toChosenCategory" {
            
            let vc = segue.destination as! ChosenViewController
            
            vc.chosenCategory = selectedCategory
            
            vc.modalPresentationStyle = .fullScreen
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let allSandwiches = [worldClaasics, diabetics, vegetarian, vegan, celiac]
        
        selectedCategory = allSandwiches[indexPath.row]
        
        self.performSegue(withIdentifier: "toChosenCategory", sender: self)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        let sandwicheZ = [worldClaasics, diabetics, vegetarian, vegan, celiac]
        
        if let currentSnadwich = sandwicheZ[indexPath.row].first {
                    cell.categoryLabel.text = currentSnadwich.category
                    cell.sandwichImage.image = UIImage(named: currentSnadwich.img!)
            }
        
        return cell
    }
    
    
}

