//
//  RecipeModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 13.08.2021.
//

import Foundation

struct RecipeModel {
    var id: String
    var name: String
    var imageURL: String
    var instruction: String
    var ingredients: [String]
    
    /// Refers to size of a recipe i.e 2 - 4 people
    var mealPortion: Int
    
    var dictionary: [String: Any] {
        return ["id": id,
                "name": name,
                "imageURL": imageURL,
                "instruction": instruction,
                "ingredients": ingredients,
                "mealPortion": mealPortion
        ]
    }
    
    static func getRecipeFromDict(recipeDetails: [String: Any]) -> RecipeModel {
        return RecipeModel(id: recipeDetails["id"] as! String,
                                   name: recipeDetails["name"] as! String,
                                   imageURL: recipeDetails["imageURL"] as! String,
                                   instruction: recipeDetails["instruction"] as! String,
                                   ingredients: recipeDetails["ingredients"] as! [String],
                                   mealPortion: recipeDetails["mealPortion"] as! Int)
        
    }
}
