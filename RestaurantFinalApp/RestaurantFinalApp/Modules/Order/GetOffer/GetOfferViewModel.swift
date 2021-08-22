//
//  GetOfferViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import Foundation

protocol GetOfferViewModelDelegate: AnyObject {
    func showAlert(message: String, title: String)
    func showLoadingIndicator(isShown: Bool)
    func kitchensLoaded()
    func backButtonPressed()
}

protocol GetOfferViewModelProtocol {
    var delegate: GetOfferViewModelDelegate? { get set }
    var kitchens: [KitchenModel] { get set }
    var mockedAmounts: [Float] { get set }
    var recipeModel: RecipeModel? { get set }
    func getKitchens()
    func quitView()
}

class GetOfferViewModel {
    var recipeModel: RecipeModel?
    var kitchens: [KitchenModel] = []
    var mockedAmounts: [Float] = []
    
    weak var delegate: GetOfferViewModelDelegate?
    
    private func getRandomPrice() -> Float {
        return Float.random(in: 30...100)
    }
}

extension GetOfferViewModel: GetOfferViewModelProtocol {
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
                
                var tempKitchens: [KitchenModel] = []

                if let kitchensDict = snapshot.value as? [String: Any] {
                    self?.kitchens.removeAll()

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
                self?.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
                print("No data available")
            }
        }
    }
    
    func quitView(){
        delegate?.backButtonPressed()
    }
}
