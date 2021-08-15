//
//  HomePageViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import Foundation
import Firebase
// import Combine

protocol HomePageViewModelDelegate: AnyObject {
    func showAlert(message: String)
    func myRecipesLoaded() // signal to view layer to say "I loaded the datas, and you can take an action."
}


class HomePageViewModel {    
    weak var delegate: HomePageViewModelDelegate?
    
    var myRecipes: [RecipeModel] = []

    func getMyRecipes() {
        FirebaseEndpoints.myRecipes.getDatabasePath.getData { [weak self] (error, snapshot) in
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
                
                self?.delegate?.myRecipesLoaded()
            }
            else {
                self?.delegate?.showAlert(message: "no data")
                print("No data available")
            }
        }
    }
    
//    private func createRecipeModel(recipeDict: [String: Any]) {
//        
//    }
}
