//
//  PaymentViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import Foundation
protocol PaymentViewModelDelegate: AnyObject {
    func showAlert(message: String)
    func paymentDetailLoaded(kitchenName: String, recipeName: String, totalPrice: String)
}

class PaymentViewModel {
    weak var delegate: PaymentViewModelDelegate?
    var recipeModel: RecipeModel?
    var kitchen: KitchenModel?
    var amount: Float?
    
    func getPaymentDetails() {
        delegate?.paymentDetailLoaded(kitchenName: kitchen?.name ?? "", recipeName: recipeModel?.name ?? "", totalPrice: "$ \(String(describing: amount))")
    }
}
