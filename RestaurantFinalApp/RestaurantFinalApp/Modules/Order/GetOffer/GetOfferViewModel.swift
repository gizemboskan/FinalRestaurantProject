//
//  GetOfferViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import Foundation

protocol GetOfferViewModelDelegate: AnyObject {
    func showAlert(message: String)
    func kitchensLoaded()
}

class GetOfferViewModel {
    var recipeModel: RecipeModel?
    var kitchens: [KitchenModel] = []
    var mockedAmounts: [Float] = []
    
    weak var delegate: GetOfferViewModelDelegate?
    
    func getKitchens(){
        kitchens.removeAll()
        FirebaseEndpoints.kitchens.getDatabasePath.getData{ [weak self] (error, snapshot) in
            if let error = error {
                self?.delegate?.showAlert(message: "error")
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                
                var tempKitchens: [KitchenModel] = []

                if let kitchensDict = snapshot.value as? [String: Any] {
                    for kitchen in kitchensDict {
                        if let kitchenDetails = kitchen.value as? [String: Any] {
                            let kitchen = KitchenModel.getKitchenFromDict(kitchenDetails: kitchenDetails)
                            
                            tempKitchens.append(kitchen)
                        }
                    }
                }
                
                let randomKitchentCount = Int.random(in: 1..<tempKitchens.count)
                tempKitchens.shuffle()
                self?.kitchens = Array(tempKitchens.prefix(through: randomKitchentCount))
                for _ in 0...randomKitchentCount {
                    self?.mockedAmounts.append(self?.getRandomPrice() ?? 0)
                }
                self?.delegate?.kitchensLoaded()
            }
            else {
                self?.delegate?.showAlert(message: "no data")
                print("No data available")
            }
        }
    }
    
    private func getRandomPrice() -> Float {
        return Float.random(in: 30...100)
    }
}
