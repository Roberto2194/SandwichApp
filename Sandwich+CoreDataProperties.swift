//
//  Sandwich+CoreDataProperties.swift
//  SandwichApp
//
//  Created by Ivan Tilev on 26/02/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//
//

import Foundation
import CoreData


extension Sandwich {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sandwich> {
        return NSFetchRequest<Sandwich>(entityName: "Sandwich")
    }

    @NSManaged public var recipe: String?
    @NSManaged public var name: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var img: String?
    @NSManaged public var category: String?
    @NSManaged public var favorite: Bool

}
