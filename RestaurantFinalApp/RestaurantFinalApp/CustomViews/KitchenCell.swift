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
    @IBOutlet weak var lovedButton: UIButton!
    @IBOutlet weak var kitchenImage: UIImageView!
    @IBOutlet weak var FoodGenreCollectionView: UICollectionView!
    @IBOutlet weak var flow: UICollectionViewFlowLayout! {
        didSet {
            flow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
   
    @IBAction func lovedButtonAction(_ sender: UIButton) {
    }
}

