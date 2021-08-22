//
//  KitchenCollectionViewCell.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 10.08.2021.
//

import UIKit

class KitchenCell: UITableViewCell {
    
    @IBOutlet weak var kitchenTitle: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var delivertTimeLabel: UILabel!
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var kitchenImage: UIImageView!
    @IBOutlet weak var imageContainerView: UIView! {
        didSet{
            imageContainerView.roundCorners(.allCorners, radius: 22)
        }
    }
    
    @IBOutlet weak var deliveryTimeTitle: UILabel! {
        didSet{
            deliveryTimeTitle.text = "delivery_time_title".localized()
        }
    }
    
    @IBOutlet weak var ratingTitle: UILabel! {
        didSet{
            ratingTitle.text = "rating_title".localized()
        }
    }
    
    public func setImage(from urlString: String) {
        HTTPClient.downloadImage(path: urlString){ data, error in
            DispatchQueue.main.async {
                guard let data = data else { return }
                self.kitchenImage.image = UIImage(data: data)
            }
        }
    }

}
