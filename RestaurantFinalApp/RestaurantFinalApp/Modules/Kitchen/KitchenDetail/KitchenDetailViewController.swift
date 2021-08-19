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
    
    let viewModel: KitchenDetailViewModel = KitchenDetailViewModel()
    let locationManager = CLLocationManager()
    
    var kitchenItem: MKPointAnnotation = MKPointAnnotation()
    var userItem: MKPointAnnotation = MKPointAnnotation()
    let regionInMeters: Double = 10000
    var userLocation: CLLocation?
    lazy var geocoder = CLGeocoder()
    
    
    // MARK: - UI Components
    @IBOutlet weak var kitchenLocationLabel: UILabel!
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
        mapView.delegate = self
        
        kitchenLocationLabel.numberOfLines = 0
        
        viewModel.getKitchenDetails()
        
        getMapDetails()
        
        checkLocationServices()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Helpers
    @IBAction func backButtonPressed(_ sender: Any) {
        backButtonPressed()
    }
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func getMapDetails(){
        
        DispatchQueue.main.async {
            let latDelta:CLLocationDegrees = 0.5
            let lonDelta:CLLocationDegrees = 0.5
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            
            
            let latitudeKitchen:CLLocationDegrees = self.viewModel.kitchenDetail?.latitude ?? 0.0
            let longitudeKitchen:CLLocationDegrees = self.viewModel.kitchenDetail?.longitude ?? 0.0
            let locationKitchen = CLLocation(latitude: latitudeKitchen, longitude: longitudeKitchen)
            let regionKitchen = MKCoordinateRegion(center: locationKitchen.coordinate, span: span)
            self.mapView.setRegion(regionKitchen, animated: false)
            
            if locationKitchen == locationKitchen {
                self.geocoder.reverseGeocodeLocation(locationKitchen) { [weak self] (placemarks, error) in
                    
                    guard let self = self else { return }
                    
                    if let error = error {
                        print(error)
                        return
                    }
                    guard let placemark = placemarks?.first else { return }
                    
                    self.kitchenLocationLabel.text = "\(placemark.thoroughfare ?? "Street"), \(placemark.locality ?? "City"), \(placemark.subLocality ?? ""), \(placemark.subThoroughfare ?? ""), \(placemark.administrativeArea ?? "")"
                }
            }
            
            let latitudeUser:CLLocationDegrees = self.viewModel.kitchenDetail?.latitude ?? 0.0
            let longitudeUser:CLLocationDegrees = self.viewModel.kitchenDetail?.longitude ?? 0.0
            let locationUser = CLLocationCoordinate2DMake(latitudeUser, longitudeUser)
            let regionUser = MKCoordinateRegion(center: locationUser, span: span)
            self.mapView.setRegion(regionUser, animated: false)
            
            self.mapView.addAnnotation(self.kitchenItem)
            self.mapView.addAnnotation(self.userItem)
            
        }
    }
    
    
    func showUserLocationCenterMap() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways:
            break
        case .restricted:
            break
        }
    }
    //    func getKitchenLocation(mapView: MKMapView) -> CLLocation {
    //        let latitude = mapView.centerCoordinate.latitude
    //        let longitude = mapView.centerCoordinate.longitude
    //
    //        return CLLocation(latitude: latitude, longitude: longitude)
    //    }
    
}
// MARK: - Location Manager Delegate
extension KitchenDetailViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
// MARK: - Map View Delegate
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
        
        
        if ((pinView?.annotation = kitchenItem) != nil) {
            pinView?.image = UIImage(named: "map_pin")
        }else {
            pinView?.image = UIImage(named: "home_pin")
        }
        return pinView
    }
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
       
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
            
            return CGSize(width: 50, height: 50)
        }
        
    }
}
// MARK: - KitchenDetailViewModelDelegate
extension KitchenDetailViewController: KitchenDetailViewModelDelegate {
    
    func userCoordinatesLoaded(longitude: Double, latitude: Double) {
        userItem.coordinate.latitude = latitude
        kitchenItem.coordinate.longitude = longitude
    }
    
    func coordinatesLoaded(longitude: Double, latitude: Double) {
        
        kitchenItem.coordinate.latitude = latitude
        kitchenItem.coordinate.longitude = longitude
    }
    
    func showAlert(message: String) {
        
    }
    
    func kitchenTitleLoaded(title: String) {
        kitchenTitleLabel.text = title
    }
    
    func mapLoaded() {
        
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
    
}
