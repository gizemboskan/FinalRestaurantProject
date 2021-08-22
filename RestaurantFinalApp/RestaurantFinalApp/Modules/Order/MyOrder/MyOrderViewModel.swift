//
//  MyOrderViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 12.08.2021.
//

import MapKit

protocol MyOrderViewModelDelegate: AnyObject {
    func activeOrderName(name: String)
    func activeOrderImage(imageData: Data)
}

protocol MyOrderViewModelProtocol {
    var delegate: MyOrderViewModelDelegate? { get set }
    var activeOrder: RecipeModel? { get set }
    func getActiveOrder()
}

final class MyOrderViewModel: NSObject {
    weak var delegate: MyOrderViewModelDelegate?
    var activeOrder: RecipeModel?
}

extension MyOrderViewModel: MyOrderViewModelProtocol {
    func getActiveOrder() {
        HTTPClient.downloadImage(path: activeOrder?.imageURL ?? ""){ data, error in
            DispatchQueue.main.async {
                guard let data = data else { return }
                self.delegate?.activeOrderImage(imageData: data)
            }
        }
        self.delegate?.activeOrderName(name: activeOrder?.name ?? "")
    }
}
