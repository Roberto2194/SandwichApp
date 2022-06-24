//
//  ChosenViewController.swift
//  SandwichApp
//
//  Created by Ivan Tilev on 04/03/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//
// This is the ViewController that will be presented when the user select a category from the main screen

import UIKit

class ChosenViewController: UIViewController, UITableViewDelegate {
    
    //Outlets
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var chosenCategory: [Sandwich] = []
    
    var chosenSandwich = Sandwich()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("The user has chosen: \(chosenCategory)")

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
    }
    
    // Back Button Pressed and go back to main screen
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "chosenToSandwich" {
            let inderPaths = self.tableView!.indexPathsForSelectedRows!
            
            let vc = segue.destination as! SandwichViewController
            
            vc.modalPresentationStyle = .fullScreen
            
            vc.sandwich = chosenSandwich
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Have to save the chosen sndwich and go to the SandwichViewController
        
        var chosen = chosenCategory[indexPath.row]
        
        chosenSandwich = chosen
        
        performSegue(withIdentifier: "chosenToSandwich", sender: self)
    }
    
}

// MARK: - UITableViewDataSource
extension ChosenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! CustomCell
        
        let currentSandwich = chosenCategory[indexPath.row]
            
            categoryLabel.text = currentSandwich.category
            cell.imageCell.image = UIImage(named: currentSandwich.img!)
            cell.sandwichNameLabel.text = currentSandwich.name
        
        return cell
    }
    
    
}
