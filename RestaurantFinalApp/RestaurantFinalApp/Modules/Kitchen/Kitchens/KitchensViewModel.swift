//
//  KitchensViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import Foundation
import Firebase

protocol KitchensViewModelDelegate: AnyObject {
    func showAlert(message: String)
    func kitchensLoaded()
    func filteringApplied(isEmpty: Bool)
}


class KitchensViewModel {
    weak var delegate: KitchensViewModelDelegate? 
    var kitchens: [KitchenModel] = []
    var filteredKitchens: [KitchenModel] = []
    var isFiltering: Bool = false
    
    func getKitchens(){
        kitchens.removeAll()
        FirebaseEndpoints.kitchens.getDatabasePath.getData{ [weak self] (error, snapshot) in
            if let error = error {
                self?.delegate?.showAlert(message: "error")
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                
                if let kitchensDict = snapshot.value as? [String: Any] {
                    for kitchen in kitchensDict {
                        if let kitchenDetails = kitchen.value as? [String: Any] {
                            let kitchen = KitchenModel.getKitchenFromDict(kitchenDetails: kitchenDetails)
                            
                            self?.kitchens.append(kitchen)
                            
                        }
                    }
                }
                
                self?.filteredKitchens.append(contentsOf: self?.kitchens ?? [])
                self?.delegate?.kitchensLoaded()
            }
            else {
                self?.delegate?.showAlert(message: "no data")
                print("No data available")
            }
        }
    }
    
    func filterKitchen(by name: String) {
        isFiltering = true
        filteredKitchens = kitchens.filter({ (kitchen: KitchenModel) -> Bool in
            return kitchen.name.lowercased().contains(name.lowercased())
        })
        delegate?.filteringApplied(isEmpty: filteredKitchens.isEmpty)
    }
}
