//
//  UIImageView+Extensions.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 17.08.2021.
//

import UIKit

extension UIImageView {
    func loadImage(withUrl url: URL) {
        HTTPClient.downloadImage(path: url.absoluteString){ data, error in
            DispatchQueue.main.async {
                guard let data = data else { return }
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
