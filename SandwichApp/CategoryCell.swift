//
//  CategoryCell.swift
//  SandwichApp
//
//  Created by Ivan Tilev on 01/03/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//
//MARK: Custom cell for the main screen

import UIKit

class CategoryCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var sandwichImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        sandwichImage.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
