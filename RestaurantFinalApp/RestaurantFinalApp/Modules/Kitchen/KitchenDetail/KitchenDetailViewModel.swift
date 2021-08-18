//
//  KitchenDetailViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import Foundation
import Firebase

protocol KitchenDetailViewModelDelegate: AnyObject {
    
    func showAlert(message: String)
    func kitchenTitleLoaded(title: String)
    func mapLoaded()
    func locationLoaded(location: String)
    func kitchenRecipesLoaded()
    func kitchenDescriptionsLoaded(descriptions: [String])
    func deliveryTimeLoaded(deliveryTime: String)
    func ratingLoaded(rating: Double)
    func ratingCountLoaded(ratingCount: Int)
    func backButtonPressed()
}

class KitchenDetailViewModel {
    weak var delegate: KitchenDetailViewModelDelegate?
    
    var kitchenDetail: KitchenModel?
    var kitchenRecipes: [RecipeModel] = []
    var kitchenID: String?
    
    func getKitchenRecipes() {
        guard let kitchenID = kitchenID else { return }
        
        kitchenRecipes.removeAll()
        FirebaseEndpoints.kitchens.getDatabasePath.child("kitchens").child(kitchenID).child("recipes").getData{ [weak self] (error, snapshot) in
            if let error = error {
                self?.delegate?.showAlert(message: "error")
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                
                if let kitchenRecipesDict = snapshot.value as? [String: Any] {
                    
                    for recipe in kitchenRecipesDict {
                        if let recipeDetails = recipe.value as? [String: Any] {
                            let kitchenRecipe = RecipeModel.getRecipeFromDict(recipeDetails: recipeDetails)
                            self?.kitchenRecipes.append(kitchenRecipe)
                        }
                        
                    }
                }
                
                self?.delegate?.kitchenRecipesLoaded()
            }
            else {
                self?.delegate?.showAlert(message: "no data")
                print("No data available")
            }
        }
    }
    
    func getKitchenDetails(){
        guard let kitchenID = kitchenID else { return }
        
        FirebaseEndpoints.kitchens.getDatabasePath.child("kitchens").child(kitchenID).getData{ [weak self] (error, snapshot) in
            if let error = error {
                self?.delegate?.showAlert(message: "error")
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                
                if let kitchenDict = snapshot.value as? [String: Any] {
                    self?.kitchenDetail = KitchenModel.getKitchenFromDict(kitchenDetails: kitchenDict)
                    self?.delegate?.kitchenTitleLoaded(title: self?.kitchenDetail?.name ?? "")
                    self?.delegate?.locationLoaded(location: self?.kitchenDetail?.location ?? "")
                    // self?.delegate?.kitchenRecipesLoaded()
                    self?.getKitchenRecipes()
                    self?.delegate?.kitchenDescriptionsLoaded(descriptions: self?.kitchenDetail?.descriptions ?? [])
                    self?.delegate?.deliveryTimeLoaded(deliveryTime: self?.kitchenDetail?.avarageDeliveryTime ?? "")
                    self?.delegate?.ratingLoaded(rating: self?.kitchenDetail?.rating ?? 0.0)
                    self?.delegate?.ratingCountLoaded(ratingCount: self?.kitchenDetail?.ratingCount ?? 0)
                    
                }
            }
            else {
                self?.delegate?.showAlert(message: "no data")
                print("No data available")
            }
        }
    }
    func quitView(){
        delegate?.backButtonPressed()
    }
}
