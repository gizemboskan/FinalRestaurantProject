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
    func coordinatesLoaded(longitude: Double, latitude: Double)
    
    func kitchenRecipesLoaded()
    func kitchenDescriptionsLoaded()
    func deliveryTimeLoaded(deliveryTime: String)
    func ratingLoaded(rating: Double)
    func ratingCountLoaded(ratingCount: Int)
    func backButtonPressed()
    func userCoordinatesLoaded(longitude: Double, latitude: Double)
    
}

class KitchenDetailViewModel {
    weak var delegate: KitchenDetailViewModelDelegate?
    
    var kitchenDetail: KitchenModel?
    var kitchenRecipes: [RecipeModel] = []
    var kitchenDescriptions: [String] = []
    
    var kitchenID: String?
    
    func getKitchenDetails(){
        guard let kitchenID = kitchenID else { return }
        
        FirebaseEndpoints.kitchens.getDatabasePath.child(kitchenID).getData{ [weak self] (error, snapshot) in
            if let error = error {
                self?.delegate?.showAlert(message: "error")
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                
                if let kitchenDict = snapshot.value as? [String: Any] {
                    self?.kitchenDetail = KitchenModel.getKitchenFromDict(kitchenDetails: kitchenDict)
                    self?.delegate?.kitchenTitleLoaded(title: self?.kitchenDetail?.name ?? "")
                    self?.delegate?.coordinatesLoaded(longitude: self?.kitchenDetail?.longitude ?? 0.0, latitude: self?.kitchenDetail?.latitude ?? 0.0)
                    
                    self?.delegate?.deliveryTimeLoaded(deliveryTime: self?.kitchenDetail?.avarageDeliveryTime ?? "")
                    self?.delegate?.ratingLoaded(rating: self?.kitchenDetail?.rating ?? 0.0)
                    self?.delegate?.ratingCountLoaded(ratingCount: self?.kitchenDetail?.ratingCount ?? 0)
                    
                    self?.kitchenDescriptions.append(contentsOf: self?.kitchenDetail?.descriptions ?? [])
                    self?.delegate?.kitchenDescriptionsLoaded()
                    
                    if let kitchenRecipesDict = self?.kitchenDetail?.recipes {
                        for recipe in kitchenRecipesDict {
                            if let recipeDetails = recipe.value as? [String: Any] {
                                let kitchenRecipe = RecipeModel.getRecipeFromDict(recipeDetails: recipeDetails)
                                self?.kitchenRecipes.append(kitchenRecipe)
                            }
                        }
                    }
                    self?.delegate?.kitchenRecipesLoaded()
                }
            }
            else {
                self?.delegate?.showAlert(message: "no data")
                print("No data available")
            }
        }
    }
    private var myUserDetail: UserModel?
    func getUserLocation(){
        
        FirebaseEndpoints.myUser.getDatabasePath.child("locationDetails").getData{ [weak self] (error, snapshot) in
            if let error = error {
                self?.delegate?.showAlert(message: "error")
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                
                if let myUserDict = snapshot.value as? [String: Any] {
                    self?.myUserDetail = UserModel.getUserFromDict(userDetails: myUserDict)
                    self?.delegate?.userCoordinatesLoaded(longitude: self?.myUserDetail?.longitude ?? 00, latitude: self?.myUserDetail?.latitude ?? 00)
                    
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
