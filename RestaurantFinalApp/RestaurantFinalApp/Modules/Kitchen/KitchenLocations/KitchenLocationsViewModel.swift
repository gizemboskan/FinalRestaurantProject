//
//  KitchenLocationsViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 21.08.2021.
//

import Foundation


import Firebase

protocol KitchenLocationsViewModelDelegate: AnyObject {
    func showAlert(message: String)
    func kitchensLoaded()
}


class KitchenLocationsViewModel {
    weak var delegate: KitchenLocationsViewModelDelegate?
    var kitchens: [KitchenModel] = []
    
    
    func getKitchens(){
        
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
                
                self?.delegate?.kitchensLoaded()
            }
            else {
                self?.delegate?.showAlert(message: "no data")
                print("No data available")
            }
        }
    }
    

}
