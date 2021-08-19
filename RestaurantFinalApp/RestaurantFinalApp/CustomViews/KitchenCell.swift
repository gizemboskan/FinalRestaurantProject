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
    @IBOutlet weak var FoodGenreCollectionView: UICollectionView!
    @IBOutlet weak var flow: UICollectionViewFlowLayout! {
        didSet {
            flow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
//    public func setImage(from urlString: String){
//        guard let imageUrl:URL = URL(string: urlString) else {return}
//        self.kitchenImage.loadImage(withUrl: imageUrl)
//    }
    public func setImage(from urlString: String) {
        HTTPClient.downloadImage(path: urlString){ data, error in
            DispatchQueue.main.async {
                guard let data = data else { return }
                self.kitchenImage.image = UIImage(data: data)
            }
        }
    }

}

