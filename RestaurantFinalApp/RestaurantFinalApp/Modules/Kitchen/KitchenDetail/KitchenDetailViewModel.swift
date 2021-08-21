//
//  KitchenDetailViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import Foundation
import Firebase
import MapKit
protocol KitchenDetailViewModelDelegate: AnyObject {
    
    func showAlert(message: String)
    func kitchenTitleLoaded(title: String)
    
    func kitchenRecipesLoaded()
    func kitchenDescriptionsLoaded()
    func deliveryTimeLoaded(deliveryTime: String)
    func ratingLoaded(rating: Double)
    func ratingCountLoaded(ratingCount: Int)
    func backButtonPressed()
    
    func kitchenPinLoaded(annotation: MKPointAnnotation)
    func userPinLoaded(annotation: MKPointAnnotation)
    func showKitchenLocationString(locationString: String)
    
}

class KitchenDetailViewModel: NSObject {
    weak var delegate: KitchenDetailViewModelDelegate?
    
    var kitchenDetail: KitchenModel?
    var kitchenRecipes: [RecipeModel] = []
    var kitchenDescriptions: [String] = []
    var mapView: MKMapView?
    
    let locationManager = CLLocationManager()
    var userLocation: CLLocation?
    lazy var geocoder = CLGeocoder()
    var kitchenID: String?
    private var myUserDetail: UserModel?
    var kitchenItem: MKPointAnnotation = MKPointAnnotation()
    var userItem: MKPointAnnotation = MKPointAnnotation()
    let regionInMeters: Double = 10000
    
    func getKitchenDetails(){
        guard let kitchenID = kitchenID else { return }
        
        FirebaseEndpoints.kitchens.getDatabasePath.child(kitchenID).getData{ [weak self] (error, snapshot) in
            if let error = error {
                self?.delegate?.showAlert(message: "error")
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                
                if let kitchenDict = snapshot.value as? [String: Any] {
                    self?.kitchenDetail = KitchenModel.getKitchenFromDict(kitchenDetails: kitchenDict)
                    self?.delegate?.kitchenTitleLoaded(title: self?.kitchenDetail?.name ?? "")
                    self?.kitchenCoordinatesLoaded(longitude: self?.kitchenDetail?.longitude ?? 0.0, latitude: self?.kitchenDetail?.latitude ?? 0.0)
                    
                    self?.delegate?.deliveryTimeLoaded(deliveryTime: self?.kitchenDetail?.avarageDeliveryTime ?? "")
                    self?.delegate?.ratingLoaded(rating: self?.kitchenDetail?.rating ?? 0.0)
                    self?.delegate?.ratingCountLoaded(ratingCount: self?.kitchenDetail?.ratingCount ?? 0)
                    
                    self?.kitchenDescriptions.append(contentsOf: self?.kitchenDetail?.descriptions ?? [])
                    self?.delegate?.kitchenDescriptionsLoaded()
                    
                    if let kitchenRecipesDict = self?.kitchenDetail?.recipes {
                        for recipe in kitchenRecipesDict {
                            if let recipeDetails = recipe.value as? [String: Any] {
                                let kitchenRecipe = RecipeModel.getRecipeFromDict(recipeDetails: recipeDetails)
                                self?.kitchenRecipes.append(kitchenRecipe)
                            }
                        }
                    }
                    self?.delegate?.kitchenRecipesLoaded()
                }
            }
            else {
                self?.delegate?.showAlert(message: "no data")
                print("No data available")
            }
        }
    }
    private func getKitchenReverseGeocode(longitude: Double, latitude: Double) {
        DispatchQueue.main.async {
            self.geocoder.reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { [weak self] (placemarks, error) in
                
                guard let self = self else { return }
                
                if let error = error {
                    print(error)
                    return
                }
                guard let placemark = placemarks?.first else { return }
                
                let locationString = "\(placemark.thoroughfare ?? "Street"), \(placemark.locality ?? "City"), \(placemark.subLocality ?? ""), \(placemark.subThoroughfare ?? ""), \(placemark.administrativeArea ?? "")"
                
                self.delegate?.showKitchenLocationString(locationString: locationString)
            }
        }
    }
    private func kitchenCoordinatesLoaded(longitude: Double, latitude: Double) {
        
        getKitchenReverseGeocode(longitude: longitude, latitude: latitude)
        setMapVisibleRegion(longitude: longitude, latitude: latitude)
        setKitchenPin(longitude: longitude, latitude: latitude)
        
    }
    func getUserLocation(){
        checkLocationServices()
        locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            guard let userLocation = locationManager.location else {
                return
            }
            print(userLocation.coordinate.latitude)
            print(userLocation.coordinate.longitude)
            let lat = userLocation.coordinate.latitude
            let long = userLocation.coordinate.longitude
            setMapVisibleRegion(longitude: long, latitude: lat)
            setUserPin(longitude: long, latitude: lat)
        }
    }
    func quitView(){
        delegate?.backButtonPressed()
    }
    
    private func setKitchenPin(longitude: Double, latitude: Double){
        kitchenItem.coordinate.latitude = latitude
        kitchenItem.coordinate.longitude = longitude
        
        delegate?.kitchenPinLoaded(annotation: self.kitchenItem)
    }
    
    
    private func setUserPin(longitude: Double, latitude: Double){
        userItem.coordinate.latitude = latitude
        userItem.coordinate.longitude = longitude
        
        delegate?.userPinLoaded(annotation: self.userItem)
        
    }
    
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        }
    }
    
    
    private func setMapVisibleRegion(longitude: Double, latitude: Double) {
        DispatchQueue.main.async {
            let latDelta:CLLocationDegrees = 0.05
            let lonDelta:CLLocationDegrees = 0.05
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            
            let lat:CLLocationDegrees = latitude
            let long:CLLocationDegrees = longitude
            let location = CLLocation(latitude: lat, longitude: long)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            
            self.mapView?.setRegion(region, animated: true)
        }
    }
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationAuthorization() {
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
    
}

// MARK: - Location Manager Delegate
extension KitchenDetailViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
// MARK: - Map View Delegate

