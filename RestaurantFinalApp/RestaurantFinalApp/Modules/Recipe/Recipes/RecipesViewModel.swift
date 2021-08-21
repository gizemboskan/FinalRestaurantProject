//
//  RecipesViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import Foundation
import Firebase

protocol RecipesViewModelDelegate: AnyObject {
    func showAlert(message: String)
    func myRecipesLoaded()
    func filteringApplied(isEmpty: Bool)
}
class RecipesViewModel {
    
    weak var delegate: RecipesViewModelDelegate?
    
    var myRecipes: [RecipeModel] = []
    var filteredRecipes: [RecipeModel] = []
    var isFiltering: Bool = false
    
    func getMyRecipes() {
        
        myRecipes.removeAll()
        FirebaseEndpoints.myUser.getDatabasePath.child("recipes").getData{ [weak self] (error, snapshot) in
            if let error = error {
                self?.delegate?.showAlert(message: "error")
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                
                if let myRecipesDict = snapshot.value as? [String: Any] {
                    
                    for recipe in myRecipesDict {
                        if let recipeDetails = recipe.value as? [String: Any] {
                            let myRecipe = RecipeModel.getRecipeFromDict(recipeDetails: recipeDetails)
                            self?.myRecipes.append(myRecipe)
                        }
                        
                    }
                }
                self?.filteredRecipes.append(contentsOf: self?.myRecipes ?? [])
                self?.delegate?.myRecipesLoaded()
            }
            else {
                self?.delegate?.showAlert(message: "no data")
                print("No data available")
            }
        }
    }
    func filterRecipe(by name: String) {
        isFiltering = true
        filteredRecipes = myRecipes.filter({ (recipe: RecipeModel) -> Bool in
            return recipe.name.lowercased().contains(name.lowercased())
        })
        delegate?.filteringApplied(isEmpty: filteredRecipes.isEmpty)
    }
    
}
