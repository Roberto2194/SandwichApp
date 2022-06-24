//
//  Utilities.swift
//  SandwichApp
//
//  Created by Ivan Tilev on 26/02/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import Foundation

//return an array of ingredients
func ingredientsToArray(ingredients: String)-> Array<String>{
    let words = ingredients.split{$0 == " "}.map(String.init)
    
    return words
}
// return the query string for the predicate
func arrayToQueryString(array: Array<String>)-> String{
    var query = "ingredients CONTAINS[c] '\(array[0])'"
    var ingredients = array
    ingredients.removeFirst()
    
    for ingredient in ingredients {
        query=query+" && ingredients CONTAINS[c] '\(ingredient)'"
    }
    
    return query
}
//create query for the predicate
func ingredientsToQuery(ingredients: String)-> String{
    return arrayToQueryString(array: ingredientsToArray(ingredients: ingredients))
    
}
//create query for the predicate with category
func ingredientsToQuery(ingredients: String, category: String)-> String{
    
    let includeCategory = arrayToQueryString(array: ingredientsToArray(ingredients: ingredients))+" && category == '\(category)'"
    return includeCategory
    
}
