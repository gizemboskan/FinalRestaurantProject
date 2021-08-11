//
//  KitchenDetailViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import UIKit
import Foundation
import MapKit

class KitchenDetailViewController: UIViewController {
    
    let viewModel: KitchenDetailViewModel = KitchenDetailViewModel()
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var recipesCollectionView: UICollectionView!
    @IBOutlet var flowlayout: UICollectionViewFlowLayout!
    @IBOutlet var kitchenTitleLabel: UILabel!
    
    @IBOutlet var kitchenDescriptionCollectionView: UICollectionView!
    @IBOutlet var flowlayout2: UICollectionViewFlowLayout!
    
    @IBOutlet weak var deliveryTimeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var rateCountLabel: UILabel!
    var items: [String] = ["Burger", "American", "A"]
    
    @IBOutlet var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
        kitchenDescriptionCollectionView.delegate = self
        kitchenDescriptionCollectionView.dataSource = self
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
    }
    
}
// MARK: - UICollectionViewDataSource and Delegate
extension KitchenDetailViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.recipesCollectionView {
            return 6
        } else {
            return items.count
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.recipesCollectionView {
            let cell = recipesCollectionView.dequeueReusableCell(withReuseIdentifier: "FavRecipesCollectionViewCell", for: indexPath) as! FavRecipesCollectionViewCell
            return cell
        }
        
        else {
            let item = items[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KitchenDescriptionCell", for: indexPath) as! KitchenDescriptionCell
            cell.kitchenDescriptionLabel.text = item
            return cell
        }
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.recipesCollectionView {
            let storyboard = UIStoryboard(name: "Recipe", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as? RecipeDetailViewController {
                
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.recipesCollectionView {
            return CGSize(width: 135, height: 165)
        }else {
            
            return CGSize(width: 50, height: 50)
        }
        
    }
}
