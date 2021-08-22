//
//  KitchensViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import Foundation
import Firebase

protocol KitchensViewModelDelegate: AnyObject {
    func showAlert(message: String, title: String)
    func showLoadingIndicator(isShown: Bool)
    func kitchensLoaded()
    func filteringApplied(isEmpty: Bool)
    func backButtonPressed()
}

protocol KitchensViewModelProtocol {
    var delegate: KitchensViewModelDelegate? { get set }
    var kitchens: [KitchenModel] { get set }
    var filteredKitchens: [KitchenModel] { get set }
    var isFiltering: Bool { get set }
    func getKitchens()
    func filterKitchen(by name: String)
    func quitView()
}

final class KitchensViewModel {
    weak var delegate: KitchensViewModelDelegate? 
    var kitchens: [KitchenModel] = []
    var filteredKitchens: [KitchenModel] = []
    var isFiltering: Bool = false
}

extension KitchensViewModel: KitchensViewModelProtocol {
    
    func getKitchens(){
        delegate?.showLoadingIndicator(isShown: true)
        FirebaseEndpoints.kitchens.getDatabasePath.getData{ [weak self] (error, snapshot) in
            self?.delegate?.showLoadingIndicator(isShown: false)
            if let error = error {
                self?.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                
                if let kitchensDict = snapshot.value as? [String: Any] {
                    self?.kitchens.removeAll()

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
                self?.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
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
    
    func quitView(){
        delegate?.backButtonPressed()
    }
}
