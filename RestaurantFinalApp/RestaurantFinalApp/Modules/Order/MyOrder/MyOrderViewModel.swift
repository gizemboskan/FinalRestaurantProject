//
//  MyOrderViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 12.08.2021.
//

import MapKit

protocol MyOrderViewModelDelegate: AnyObject {
}

protocol MyOrderViewModelProtocol {
    var delegate: MyOrderViewModelDelegate? { get set }
}

final class MyOrderViewModel: NSObject {
    weak var delegate: MyOrderViewModelDelegate?
}

extension MyOrderViewModel: MyOrderViewModelProtocol {
    
}
