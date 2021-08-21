//
//  RecipeDetailViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import Foundation
import Firebase

protocol RecipeDetailViewModelDelegate: AnyObject {
    func showAlert(message: String)
    func titleLoaded(title: String)
    func imageLoaded(image: String)
    func instructionLoaded(instruction: String)
    func ingredientsLoaded(ingredients: [String])
    func showLoadingIndicator(isShown: Bool)
    func shareButtonPressed(_ sender: Any)
    func backButtonPressed()
    func favProcessCompleted(favStateImage: String)
    func orderButtonPressed()
    func editRecipeButtonPressed()
    
}

class RecipeDetailViewModel {
    weak var delegate: RecipeDetailViewModelDelegate?
    
    var recipeID: String?
    var kitchenID: String?
    var recipeDetail: RecipeModel?
    
    func getDetails() {
        if let kitchenID = kitchenID {
            getRecipeDetails(from:  FirebaseEndpoints.kitchens.getDatabasePath.child(kitchenID).child("recipes"))
        } else {
            getRecipeDetails(from:  FirebaseEndpoints.myUser.getDatabasePath.child("recipes"))
        }
    }
    
    
    private func getRecipeDetails(from databaseReference: DatabaseReference){
        guard let recipeID = recipeID else { return }
        databaseReference.child(recipeID).getData{ [weak self] (error, snapshot) in
            if let error = error {
                self?.delegate?.showAlert(message: "error")
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                
                if let myRecipeDict = snapshot.value as? [String: Any] {
                    self?.recipeDetail = RecipeModel.getRecipeFromDict(recipeDetails: myRecipeDict)
                    self?.delegate?.titleLoaded(title: self?.recipeDetail?.name ?? "")
                    self?.delegate?.imageLoaded(image: self?.recipeDetail?.imageURL ?? "")
                    self?.delegate?.instructionLoaded(instruction: self?.recipeDetail?.instruction ?? "")
                    self?.delegate?.ingredientsLoaded(ingredients: self?.recipeDetail?.ingredients ?? [])
                    self?.setFavState()
                }
            }
            else {
                self?.delegate?.showAlert(message: "no data")
                print("No data available")
            }
        }
    }
    
    private func setFavState() {
        FirebaseEndpoints.myUser.getDatabasePath.child("recipes").getData{ [weak self] (error, snapshot) in
            if let error = error {
                self?.delegate?.showAlert(message: "error")
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                
                var myRecipes: [RecipeModel] = []
                
                if let myRecipesDict = snapshot.value as? [String: Any] {
                    
                    for recipe in myRecipesDict {
                        if let recipeDetails = recipe.value as? [String: Any] {
                            let myRecipe = RecipeModel.getRecipeFromDict(recipeDetails: recipeDetails)
                            myRecipes.append(myRecipe)
                        }
                    }
                    
                    if myRecipes.contains(where: { $0.id == self?.recipeDetail?.id }) {
                        self?.delegate?.favProcessCompleted(favStateImage: "filledFav")
                        print("fav process done. dolu kalp")
                    } else {
                        self?.delegate?.favProcessCompleted(favStateImage: "fav")
                        print("fav process done. boş kalp")
                    }
                }
            }
            else {
                self?.delegate?.showAlert(message: "no data")
                print("No data available")
            }
        }
    }
    
    func changeFavorite(){
        FirebaseEndpoints.myUser.getDatabasePath.child("recipes").getData{ [weak self] (error, snapshot) in
            if let error = error {
                self?.delegate?.showAlert(message: "error")
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                
                var myRecipes: [RecipeModel] = []
                
                if let myRecipesDict = snapshot.value as? [String: Any] {
                    
                    for recipe in myRecipesDict {
                        if let recipeDetails = recipe.value as? [String: Any] {
                            let myRecipe = RecipeModel.getRecipeFromDict(recipeDetails: recipeDetails)
                            myRecipes.append(myRecipe)
                        }
                    }
                    
                    if let recipeId = self?.recipeDetail?.id, myRecipes.contains(where: { $0.id == recipeId}) {
                        FirebaseEndpoints.myUser.getDatabasePath.child("recipes").child(recipeId).removeValue { error, reference in
                            
                            self?.delegate?.favProcessCompleted(favStateImage: "fav")
                            print ("boş kalbe değişim")
                        }
                    } else {
                        if let recipeDict = self?.recipeDetail?.dictionary {
                            if let recipeId = self?.recipeDetail?.id {
                                FirebaseEndpoints.myUser.getDatabasePath.child("recipes").child(recipeId).setValue(recipeDict) { error, reference in
                                    
                                    self?.delegate?.favProcessCompleted(favStateImage: "filledFav")
                                    print("dolu kalbe değişim")
                                    
                                }
                            }
                        }
                        
                    }
                }
            }
            else {
                print("no data but we can add new one.")
                if let recipeDict = self?.recipeDetail?.dictionary {
                    if let recipeId = self?.recipeDetail?.id {
                        FirebaseEndpoints.myUser.getDatabasePath.child("recipes").child(recipeId).setValue(recipeDict) { error, reference in
                            
                            self?.delegate?.favProcessCompleted(favStateImage: "filledFav")
                            print("dolu kalbe değişim")
                            
                        }
                    }
                }
            }
        }
    }
    
    func shareRecipe(_ sender: Any){
        delegate?.shareButtonPressed(sender)
    }
    
    func quitView(){
        delegate?.backButtonPressed()
    }
    
    func orderRecipe(){
        delegate?.orderButtonPressed()
    }
    
    func editRecipe(){
        delegate?.editRecipeButtonPressed()
    }
    
}
