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
    func completePayment()
    func quitView()
}

final class PaymentViewModel {
    weak var delegate: PaymentViewModelDelegate?
    var recipeModel: RecipeModel?
    var kitchen: KitchenModel?
    var amount: Float?
}

extension PaymentViewModel: PaymentViewModelProtocol {
    
    func completePayment() {
        guard let recipeModel = recipeModel else { return }
        let recipeDataDict:[String: String] = ["name" : recipeModel.name, "imageURL" : recipeModel.imageURL]
        let recipeDataDict2:[String: RecipeModel] = ["recipe" : recipeModel]

        NotificationCenter.default.post(name: .orderActivated, object: nil, userInfo: recipeDataDict2)
    }
    func getPaymentDetails() {
        let formattedAmount = String(format: "%.2f", amount ?? 0)
        delegate?.paymentDetailLoaded(kitchenName: kitchen?.name ?? "", recipeName: recipeModel?.name ?? "", totalPrice: "$ \(formattedAmount)")
    }
    
    func quitView(){
        delegate?.backButtonPressed()
    }
}
