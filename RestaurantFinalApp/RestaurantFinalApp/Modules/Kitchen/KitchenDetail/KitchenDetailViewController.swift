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
    // MARK: - Properties
    
    var viewModel: KitchenDetailViewModelProtocol = KitchenDetailViewModel()
    let locationManager = CLLocationManager()
    
    
    var kitchenItem: MKPointAnnotation = MKPointAnnotation()
    var userItem: MKPointAnnotation = MKPointAnnotation()
    
    
    // MARK: - UI Components
    @IBOutlet weak var kitchenLocationLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var recipesCollectionView: UICollectionView!
    @IBOutlet weak var flowlayout: UICollectionViewFlowLayout!
    @IBOutlet weak var kitchenTitleLabel: UILabel!
    
    @IBOutlet weak var kitchenDescriptionCollectionView: UICollectionView!
    @IBOutlet weak var flowlayout2: UICollectionViewFlowLayout!
    @IBOutlet weak var kitchenLocationView: UIView!
    
    @IBOutlet weak var deliveryTimeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var rateCountLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var kitchenDetailView: UIView!
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        viewModel.delegate = self
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
        kitchenDescriptionCollectionView.delegate = self
        kitchenDescriptionCollectionView.dataSource = self
        
        mapView.delegate = self
        
        
        kitchenLocationLabel.numberOfLines = 0
        
        viewModel.getKitchenDetails()
        viewModel.getUserLocation()
        
        kitchenDetailView.roundCorners([.topLeft, .topRight], radius: 40)
        kitchenLocationView.roundCorners(.allCorners, radius: 15)
        kitchenDescriptionCollectionView.roundCorners(.allCorners, radius: 20)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideKeyboardWhenTappedAround()        
    }
    
    // MARK: - Helpers
    @IBAction func backButtonPressed(_ sender: Any) {
        viewModel.quitView()
    }
    
}

// MARK: - UICollectionViewDataSource and Delegate
extension KitchenDetailViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.recipesCollectionView {
            return viewModel.kitchenRecipes.count
        } else {
            return viewModel.kitchenDescriptions.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.recipesCollectionView {
            let cell = recipesCollectionView.dequeueReusableCell(withReuseIdentifier: "FavRecipesCollectionViewCell", for: indexPath) as! FavRecipesCollectionViewCell
            let kitchenRecipeModel = viewModel.kitchenRecipes[indexPath.row]
            cell.favRecipeName.text = kitchenRecipeModel.name
            cell.setImage(from: kitchenRecipeModel.imageURL)
            return cell
        } else {
            let item = viewModel.kitchenDescriptions[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KitchenDescriptionCell", for: indexPath) as! KitchenDescriptionCell
            cell.kitchenDescriptionLabel.text = item
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.recipesCollectionView {
            let storyboard = UIStoryboard(name: "Recipe", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as? RecipeDetailViewController {
                vc.viewModel.kitchenID = viewModel.kitchenID
                vc.viewModel.recipeID = viewModel.kitchenRecipes[indexPath.row].id
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.recipesCollectionView {
            return CGSize(width: 135, height: 165)
        }else {
            
            return CGSize(width: 80, height: 50)
        }
        
    }
}

// MARK: - MKMapViewDelegate
extension KitchenDetailViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MKPointAnnotation else { return nil }
        let reuseId = "Pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            
        }else {
            pinView?.annotation = annotation
        }
        
        if pinView?.annotation === kitchenItem {
            pinView?.image = UIImage(named: "map_pin")
        } else {
            pinView?.image = UIImage(named: "home_pin")
        }
        return pinView
    }
    
}

// MARK: - KitchenDetailViewModelDelegate
extension KitchenDetailViewController: KitchenDetailViewModelDelegate {
    func kitchenPinLoaded(annotation: MKPointAnnotation) {
        kitchenItem = annotation
        DispatchQueue.main.async {
            self.mapView?.addAnnotation(self.kitchenItem)
        }        
    }
    
    func userPinLoaded(annotation: MKPointAnnotation) {
        userItem = annotation
        DispatchQueue.main.async {
            self.mapView?.addAnnotation(self.userItem)
        }
    }
    
    
    func showKitchenLocationString(locationString: String) {
        
        kitchenLocationLabel.text = locationString
    }
    
    func showAlert(message: String, title: String) {
        showAlertController(message: message, title: title)
    }
    
    func showLoadingIndicator(isShown: Bool) {
        if isShown {
            startLoading()
        } else {
            stopLoading()
        }
    }
    
    func kitchenTitleLoaded(title: String) {
        kitchenTitleLabel.text = title
    }
    
    func kitchenRecipesLoaded() {
        recipesCollectionView.reloadData()
    }
    
    func kitchenDescriptionsLoaded() {
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
    
    func zoomRegion(region: MKCoordinateRegion) {
        mapView.setRegion(region, animated: true)
    }
}
