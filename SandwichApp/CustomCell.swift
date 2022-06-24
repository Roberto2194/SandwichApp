//
//  CustomCell.swift
//  SandwichApp
//
//  Created by Ivan Tilev on 26/02/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var sandwichNameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ingredientesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ingredientesLabel.textColor = .white
        

        imageCell.layer.cornerRadius = 20
        imageCell.contentMode = .scaleAspectFill
//        imageCell.layer.borderWidth = 3
//        imageCell.layer.borderColor = UIColor.black.cgColor
        
//        sandwichNameLabel.font = UIFont(name: "chalkbuster", size: 16)
        
        categoryLabel.font = .systemFont(ofSize: 14)
        categoryLabel.backgroundColor = .systemGray3
        categoryLabel.layer.masksToBounds = true
        categoryLabel.layer.cornerRadius = 8
        categoryLabel.backgroundColor?.withAlphaComponent(0.1)
        
        contentView.layer.backgroundColor = #colorLiteral(red: 0.9705761075, green: 0.6709914804, blue: 0.02477554418, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
