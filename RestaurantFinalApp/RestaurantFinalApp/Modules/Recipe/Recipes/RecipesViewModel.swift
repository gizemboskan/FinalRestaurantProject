//
//  RecipesViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import Foundation
import Firebase

protocol RecipesViewModelDelegate: AnyObject {
    func showAlert(message: String, title: String)
    func showLoadingIndicator(isShown: Bool)
    func myRecipesLoaded()
    func filteringApplied(isEmpty: Bool)
    func backButtonPressed()
}

protocol RecipesViewModelProtocol {
    var delegate: RecipesViewModelDelegate? { get set }
    var myRecipes: [RecipeModel] { get set }
    var filteredRecipes: [RecipeModel] { get set }
    var isFiltering: Bool { get set }
    func getMyRecipes()
    func filterRecipe(by name: String)
    func quitView()
}

final class RecipesViewModel {
    
    weak var delegate: RecipesViewModelDelegate?
    
    var myRecipes: [RecipeModel] = []
    var filteredRecipes: [RecipeModel] = []
    var isFiltering: Bool = false
}

extension RecipesViewModel: RecipesViewModelProtocol {
    
    func getMyRecipes() {
        delegate?.showLoadingIndicator(isShown: true)
        FirebaseEndpoints.myUser.getDatabasePath.child("recipes").getData{ [weak self] (error, snapshot) in
            self?.delegate?.showLoadingIndicator(isShown: false)
            if let error = error {
                self?.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                
                if let myRecipesDict = snapshot.value as? [String: Any] {
                    self?.myRecipes.removeAll()
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
                self?.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
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
 
    func quitView() {
        delegate?.backButtonPressed()
    }
}
