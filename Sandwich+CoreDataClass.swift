//
//  Sandwich+CoreDataClass.swift
//  SandwichApp
//
//  Created by Ivan Tilev on 26/02/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Sandwich)
public class Sandwich: NSManagedObject {
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
}
