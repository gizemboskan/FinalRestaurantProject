//
//  KitchenCollectionViewCell.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 10.08.2021.
//

import UIKit

class KitchenCell: UITableViewCell {
    
    var kitchenDescs: [String] = []
    
    @IBOutlet weak var kitchenTitle: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var delivertTimeLabel: UILabel!
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var kitchenImage: UIImageView! {
        didSet{
            self.roundCorners(.allCorners, radius: 22)
        }
    }
    @IBOutlet weak var FoodGenreCollectionView: UICollectionView!
    @IBOutlet weak var flow: UICollectionViewFlowLayout! {
        didSet {
            flow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//            FoodGenreCollectionView.delegate = self
//            FoodGenreCollectionView.dataSource = self
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

extension KitchenCell:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kitchenDescs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = kitchenDescs[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KitchenDescriptionCell", for: indexPath) as! KitchenDescriptionCell
        cell.kitchenDescriptionLabel.text = item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}
