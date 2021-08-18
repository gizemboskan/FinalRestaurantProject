//
//  KitchenDetailViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import UIKit
import Foundation
import MapKit

class KitchenDetailViewController: UIViewController, MKMapViewDelegate {
    // MARK: - Properties
    
    let viewModel: KitchenDetailViewModel = KitchenDetailViewModel()
    
    // MARK: - UI Components
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var recipesCollectionView: UICollectionView!
    @IBOutlet weak var flowlayout: UICollectionViewFlowLayout!
    @IBOutlet weak var kitchenTitleLabel: UILabel!
    
    @IBOutlet weak var kitchenDescriptionCollectionView: UICollectionView!
    @IBOutlet weak var flowlayout2: UICollectionViewFlowLayout!
    
    @IBOutlet weak var deliveryTimeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var rateCountLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        viewModel.delegate = self
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
        kitchenDescriptionCollectionView.delegate = self
        kitchenDescriptionCollectionView.dataSource = self
    }
    // MARK: - Helpers
    @IBAction func backButtonPressed(_ sender: Any) {
        backButtonPressed()
    }
    
}
// MARK: - UICollectionViewDataSource and Delegate
extension KitchenDetailViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.recipesCollectionView {
            return viewModel.kitchenDetail?.recipes.count ?? 0 
        } else {
            return viewModel.kitchenDetail?.descriptions.count ?? 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.recipesCollectionView {
            let cell = recipesCollectionView.dequeueReusableCell(withReuseIdentifier: "FavRecipesCollectionViewCell", for: indexPath) as! FavRecipesCollectionViewCell
            let kitchenRecipeModel = viewModel.kitchenRecipes[indexPath.row]
            cell.favRecipeName.text = kitchenRecipeModel.name
            cell.setImage(from: kitchenRecipeModel.imageURL)
            return cell
        }
        
        else {
            let item = viewModel.kitchenDetail?.descriptions[indexPath.row]
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
// MARK: - KitchenDetailViewModelDelegate
extension KitchenDetailViewController: KitchenDetailViewModelDelegate {
    func showAlert(message: String) {
        
    }
    
    func kitchenTitleLoaded(title: String) {
        kitchenTitleLabel.text = title
    }
    
    func mapLoaded() {
        
    }
    
    func locationLoaded(location: String) {
        locationLabel.text = location
    }
    
    func kitchenRecipesLoaded() {
        recipesCollectionView.reloadData()
    }
    
    func kitchenDescriptionsLoaded(descriptions: [String]) {
        kitchenDescriptionCollectionView.reloadData()
    }
    
    func deliveryTimeLoaded(deliveryTime: String) {
        deliveryTimeLabel.text = deliveryTime
    }
    
    func ratingLoaded(rating: Double) {
        ratingLabel.text = String(rating)
    }
    
    func ratingCountLoaded(ratingCount: Int) {
        rateCountLabel.text = String(ratingCount)
    }
    
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
}
