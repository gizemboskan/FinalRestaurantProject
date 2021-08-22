//
//  PaymentViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import Foundation
protocol PaymentViewModelDelegate: AnyObject {
    func paymentDetailLoaded(kitchenName: String, recipeName: String, totalPrice: String)
    func backButtonPressed()
}

protocol PaymentViewModelProtocol {
    var delegate: PaymentViewModelDelegate? { get set }
    var recipeModel: RecipeModel? { get set }
    var kitchen: KitchenModel? { get set }
    var amount: Float? { get set }
    func getPaymentDetails()
    func quitView()
}

final class PaymentViewModel {
    weak var delegate: PaymentViewModelDelegate?
    var recipeModel: RecipeModel?
    var kitchen: KitchenModel?
    var amount: Float?
}

extension PaymentViewModel: PaymentViewModelProtocol {
    func getPaymentDetails() {
        let formattedAmount = String(format: "%.2f", amount ?? 0)
        delegate?.paymentDetailLoaded(kitchenName: kitchen?.name ?? "", recipeName: recipeModel?.name ?? "", totalPrice: "$ \(formattedAmount)")
    }
    
    func quitView(){
        delegate?.backButtonPressed()
    }
}
