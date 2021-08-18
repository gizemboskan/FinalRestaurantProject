//
//  FavRecipesCollectionViewCell.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 10.08.2021.
//

import UIKit

class FavRecipesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var favRecipeImageView: UIImageView!
    @IBOutlet var favRecipeName: UILabel!
    
    public func setImage(from urlString: String) {
        HTTPClient.downloadImage(path: urlString){ data, error in
            DispatchQueue.main.async {
                guard let data = data else { return }
                self.favRecipeImageView.image = UIImage(data: data)
            }
        }
    }
}
