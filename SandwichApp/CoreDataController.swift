//
//  CoreDataController.swift
//  SandwichApp
//
//  Created by Ivan Tilev on 26/02/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//
// MARK: Core Data Controller, that is responsable for fetching and updating the CoreData Model

import Foundation
import CoreData
import UIKit

class CoreDataController {
    
    static let shared = CoreDataController() //singleton
    
    private var context: NSManagedObjectContext //contesto dove vengono salvati i dati
    
    private init() {
        // AppDelegate è l’oggetto delegato alla gestione degli stati della tua applicazione
        // accedo tramite la classe UIApplication
        let application = UIApplication.shared.delegate as! AppDelegate
        // persistantContainer mette in relazione il tuo xcatdatamodeld
        // con i dati reali memorizzati nel dispositivo e gestiti dall’ManagedObjectContext
        self.context = application.persistentContainer.viewContext
    }
    
    func addSandwich(name: String, ingredients: String, recipe: String, category: String, img: String) {
        // per recuperare l’Entity dal tuo xcatdatamodeld
        let entity = NSEntityDescription.entity(forEntityName: "Sandwich", in: self.context)
        // per creare un NSManagedObject serve l'entity del xcatdatamodeld e il contesto in cui viene salvato
        let newSandwich = Sandwich(entity: entity!, insertInto: self.context)
        newSandwich.name = name
        newSandwich.ingredients = ingredients
        newSandwich.recipe = recipe
        newSandwich.category = category
        newSandwich.img = img
        
        // forzo il contesto a salvare effettivamente in memoria
        do {
            try self.context.save()
        } catch let error {
            print("[SupDog] Problem with the saving: \(newSandwich.name!) in memory")
            print("  Print error: \n \(error) \n")
        }
        
        print("[SupDog] Sandwich \(newSandwich.name!) saved correctly!")
    }
    
    func loadAllSandwichs() {
        print("[SupDog] Load all sandwiches from the context ")
        // faccio richiesta al context di recuperare i dati dalla memoria
        let fetchRequest: NSFetchRequest<Sandwich> = Sandwich.fetchRequest()
        
        do {
            let array = try self.context.fetch(fetchRequest)
            
            guard array.count > 0 else {print("[SupDog] No elements in memory "); return}
            
            for x in array {
                let sandwich = x
                print("Sandwich: \(sandwich.name!) \nIngredients: \(sandwich.ingredients!) \nRecipe: \(sandwich.recipe!)\nCategory: \(sandwich.category!)\nImg: \(sandwich.img!)\n")
            }
            
        } catch let error {
            print("[SupDog] Problem execution FetchRequest")
            print("  Print error \n \(error) \n")
        }
    }
    
    func loadAllSandwichs2()-> Array<Sandwich>{
        var newArray = [Sandwich]()
        print("[SupDog] Load all sandwiches from the context ")
        // faccio richiesta al context di recuperare i dati dalla memoria
        let fetchRequest: NSFetchRequest<Sandwich> = Sandwich.fetchRequest()
        
        do {
            let array = try self.context.fetch(fetchRequest)
            guard array.count > 0 else {print("[SupDog] No elements in memory "); return newArray }
// add to the empty newarray all the sandwiches
            newArray.append(contentsOf: array)
            for x in array {
                let sandwich = x
                print("Sandwich: \(sandwich.name!) \nIngredients: \(sandwich.ingredients!) \nRecipe: \(sandwich.recipe!)\nCategory: \(sandwich.category!)\nImg: \(sandwich.img!)\n")
            }
            
        } catch let error {
            print("[SupDog] Problem execution FetchRequest")
            print("  Print error \n \(error) \n")
        }
        
        return newArray
    }
    
    
    
    func loadFromIngredients(ingredient: String) {
        print("[SupDog] Get sandwiches from database.\n")
        
        let fetchRequest: NSFetchRequest<Sandwich> = Sandwich.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: ingredientsToQuery(ingredients: ingredient))
        fetchRequest.predicate = predicate
        
        do {
            let array = try self.context.fetch(fetchRequest)
            
            guard array.count > 0 else {print("[*] No elements to read "); return}
            
            for x in array {
                let sandwich = x
                print("Sandwich: \(sandwich.name!) \nIngredients: \(sandwich.ingredients!) \nRecipe: \(sandwich.recipe!)\nCategory: \(sandwich.category!)\nImg: \(sandwich.img!)\n")
            }
            
        } catch let error {
            print("[SupDog] Problem with FetchRequest")
            print("  Print the error: \n \(error) \n")
        }
    }
    
    func loadFromIngredients2(ingredient: String)-> Array<Sandwich>{
        var newArray = [Sandwich]()
        print("[SupDog] Get sandwiches from database.\n")
        
        let fetchRequest: NSFetchRequest<Sandwich> = Sandwich.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: ingredientsToQuery(ingredients: ingredient))
        fetchRequest.predicate = predicate
        
        do {
            let array = try self.context.fetch(fetchRequest)
            
            guard array.count > 0 else {print("[*] No elements to read "); return newArray}
            
            // add to the empty newarray all the sandwiches
            newArray.append(contentsOf: array)
            
            for x in array {
                let sandwich = x
                print("Sandwich: \(sandwich.name!) \nIngredients: \(sandwich.ingredients!) \nRecipe: \(sandwich.recipe!)\nCategory: \(sandwich.category!)\nImg: \(sandwich.img!)\n")
            }
            
        } catch let error {
            print("[SupDog] Problem with FetchRequest")
            print("  Print the error: \n \(error) \n")
        }
        
        return newArray
    }
    
    func loadFromIngredientsAndCategory2(ingredient: String, category: String)-> Array<Sandwich>{
            var newArray = [Sandwich]()
            print("[*] Get sandwiches from database.\n")
            
            let fetchRequest: NSFetchRequest<Sandwich> = Sandwich.fetchRequest()
            fetchRequest.returnsObjectsAsFaults = false
    //create query for the predicate
            let query = ingredientsToQuery(ingredients: ingredient, category: category)
            
            let predicate = NSPredicate(format: query)
            fetchRequest.predicate = predicate
            
            do {
                let array = try self.context.fetch(fetchRequest)
                
                guard array.count > 0 else {print("[*] No elements to read "); return newArray}
                
                // add to the empty newarray all the sandwiches
                newArray.append(contentsOf: array)
                
                for x in array {
                    let sandwich = x
                    print("Sandwich: \(sandwich.name!) \nIngredients: \(sandwich.ingredients!) \nRecipe: \(sandwich.recipe!)\nCategory: \(sandwich.category!)\nImg: \(sandwich.img!)\n")
                }
                
            } catch let error {
                print("[SupDog] Problem with FetchRequest")
                print("  Print the error: \n \(error) \n")
            }
        
        return newArray
        }
    
    func loadFromIngredientsAndCategory(ingredient: String, category: String) {
        print("[*] Get sandwiches from database.\n")
        
        let fetchRequest: NSFetchRequest<Sandwich> = Sandwich.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
//create query for the predicate
        let query = ingredientsToQuery(ingredients: ingredient, category: category)
        
        let predicate = NSPredicate(format: query)
        fetchRequest.predicate = predicate
        
        do {
            let array = try self.context.fetch(fetchRequest)
            
            guard array.count > 0 else {print("[*] No elements to read "); return}
            
            for x in array {
                let sandwich = x
                print("Sandwich: \(sandwich.name!) \nIngredients: \(sandwich.ingredients!) \nRecipe: \(sandwich.recipe!)\nCategory: \(sandwich.category!)\nImg: \(sandwich.img!)\n")
            }
            
        } catch let error {
            print("[SupDog] Problem with FetchRequest")
            print("  Print the error: \n \(error) \n")
        }
    }
    
    func deleteAllData() {
        // faccio richiesta al context di recuperare i dati dalla memoria
        let fetchRequest: NSFetchRequest<Sandwich> = Sandwich.fetchRequest()
        
        do {
            let array = try self.context.fetch(fetchRequest)
            
            guard array.count > 0 else {print("[SupDog] No elements in memory "); return}
            
            for sandwich in array {
                self.context.delete(sandwich)
            }
            
        } catch let error {
            print("Delete data error:", error)
        }
    }
}
