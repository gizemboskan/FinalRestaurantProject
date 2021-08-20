//
//  UIView+Extensions.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 19.08.2021.
//

import UIKit

extension UIView{
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = getCorner(from: corners)
        layer.masksToBounds = true
    }
    
    private func getCorner(from: UIRectCorner) -> CACornerMask {
        switch from {
        case .allCorners:
            return [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .bottomLeft:
            return [.layerMinXMaxYCorner]
        case .bottomRight:
            return [.layerMaxXMaxYCorner]
        case .topLeft:
            return [.layerMinXMinYCorner]
        case .topRight:
            return [.layerMaxXMinYCorner]
        default:
            return [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
}
