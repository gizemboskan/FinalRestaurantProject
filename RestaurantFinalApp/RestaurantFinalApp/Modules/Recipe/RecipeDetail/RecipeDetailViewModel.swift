//
//  RecipeDetailViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import Foundation

protocol RecipeDetailViewModelDelegate: AnyObject {
    func showAlert(message: String)
    func titleLoaded(title: String)
    
}

class RecipeDetailViewModel {
    weak var delegate: RecipeDetailViewModelDelegate?
    
   private var myRecipe: RecipeModel?
    
    func getRecipeDetails(){
        delegate?.titleLoaded(title: myRecipe?.name ?? "")
    }
    
}
