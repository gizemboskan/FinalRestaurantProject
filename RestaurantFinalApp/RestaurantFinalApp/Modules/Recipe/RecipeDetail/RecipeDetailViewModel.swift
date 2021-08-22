//
//  RecipeDetailViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import Foundation
import Firebase

protocol RecipeDetailViewModelDelegate: AnyObject {
    func showAlert(message: String, title: String)
    func showLoadingIndicator(isShown: Bool)
    func titleLoaded(title: String)
    func imageLoaded(image: String)
    func instructionLoaded(instruction: String)
    func ingredientsLoaded(ingredients: [String])
    func shareButtonPressed()
    func backButtonPressed()
    func favProcessCompleted(favStateImage: String)
    func askForFav(isFav: Bool)
    func orderButtonPressed()
    func editRecipeButtonPressed()
}

protocol RecipeDetailViewModelProtocol {
    var delegate: RecipeDetailViewModelDelegate? { get set }
    var recipeID: String? { get set }
    var kitchenID: String? { get set }
    func getDetails()
    func showFavAlert()
    func changeFavorite()
    func shareRecipe()
    func editRecipe()
    func orderRecipe()
    func quitView()
    var recipeDetail: RecipeModel? { get set }
}

final class RecipeDetailViewModel {
    weak var delegate: RecipeDetailViewModelDelegate?
    
    var recipeID: String?
    var kitchenID: String?
    var recipeDetail: RecipeModel?
    
    private var isFav: Bool = false {
        didSet {
            delegate?.favProcessCompleted(favStateImage: isFav ? "filledFav" : "fav")
        }
    }
    
    private func getRecipeDetails(from databaseReference: DatabaseReference){
        delegate?.showLoadingIndicator(isShown: true)
        guard let recipeID = recipeID else { return }
        databaseReference.child(recipeID).getData{ [weak self] (error, snapshot) in
            self?.delegate?.showLoadingIndicator(isShown: false)
            if let error = error {
                self?.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
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
                self?.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
                print("No data available")
            }
        }
    }
    
    private func setFavState() {
        delegate?.showLoadingIndicator(isShown: true)
        FirebaseEndpoints.myUser.getDatabasePath.child("recipes").getData{ [weak self] (error, snapshot) in
            self?.delegate?.showLoadingIndicator(isShown: false)
            if let error = error {
                self?.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
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
                        self?.isFav = true
                        print("fav process done. dolu kalp")
                    } else {
                        self?.isFav = false
                        print("fav process done. boş kalp")
                    }
                }
            }
            else {
                self?.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
                print("No data available")
            }
        }
    }
}
extension RecipeDetailViewModel: RecipeDetailViewModelProtocol {
    func getDetails() {
        if let kitchenID = kitchenID {
            getRecipeDetails(from:  FirebaseEndpoints.kitchens.getDatabasePath.child(kitchenID).child("recipes"))
        } else {
            getRecipeDetails(from:  FirebaseEndpoints.myUser.getDatabasePath.child("recipes"))
        }
    }
    
    func showFavAlert() {
        delegate?.askForFav(isFav: isFav)
    }
    
    func changeFavorite(){
        delegate?.showLoadingIndicator(isShown: true)
        FirebaseEndpoints.myUser.getDatabasePath.child("recipes").getData{ [weak self] (error, snapshot) in
            self?.delegate?.showLoadingIndicator(isShown: false)
            if let error = error {
                self?.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
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
                            
                            self?.isFav = false
                            print ("boş kalbe değişim")
                        }
                    } else {
                        if let recipeDict = self?.recipeDetail?.dictionary {
                            if let recipeId = self?.recipeDetail?.id {
                                FirebaseEndpoints.myUser.getDatabasePath.child("recipes").child(recipeId).setValue(recipeDict) { error, reference in
                                    
                                    self?.isFav = true
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
                            
                            self?.isFav = true
                            print("dolu kalbe değişim")
                            
                        }
                    }
                }
            }
        }
    }
    
    func shareRecipe() {
        delegate?.shareButtonPressed()
    }
    
    func quitView() {
        delegate?.backButtonPressed()
    }
    
    func orderRecipe() {
        delegate?.orderButtonPressed()
    }
    
    func editRecipe() {
        delegate?.editRecipeButtonPressed()
    }
}

