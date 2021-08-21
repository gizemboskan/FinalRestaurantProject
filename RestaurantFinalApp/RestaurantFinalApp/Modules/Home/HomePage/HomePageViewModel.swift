//
//  HomePageViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import Foundation
import Firebase
import MapKit

protocol HomePageViewModelDelegate: AnyObject {
    func showAlert(message: String)
    func myRecipesLoaded() // signal to view layer to say "I loaded the datas, and you can take an action."
    func kitchensLoaded()
    func showLocationString(locationString: String)
}


class HomePageViewModel: NSObject {
    weak var delegate: HomePageViewModelDelegate?
    
    var myRecipes: [RecipeModel] = []
    var kitchens: [KitchenModel] = []
    private var myUserDetail: UserModel?
    let locationManager = CLLocationManager()
    var userLocation: CLLocation?
    lazy var geocoder = CLGeocoder()
    func getMyRecipes() {
        myRecipes.removeAll()
        FirebaseEndpoints.myUser.getDatabasePath.child("recipes").getData{ [weak self] (error, snapshot) in
            if let error = error {
                self?.delegate?.showAlert(message: "error")
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                
                var tempRecipes: [RecipeModel] = []
                if let myRecipesDict = snapshot.value as? [String: Any] {
                    
                    for recipe in myRecipesDict {
                        if let recipeDetails = recipe.value as? [String: Any] {
                            let myRecipe = RecipeModel.getRecipeFromDict(recipeDetails: recipeDetails)
                            
                            
                            tempRecipes.append(myRecipe)
                        }
                    }
                    
                    self?.myRecipes = Array(tempRecipes.prefix(5))
                }
                
                self?.delegate?.myRecipesLoaded()
            }
            else {
                self?.delegate?.showAlert(message: "no data")
                print("No data available")
            }
        }
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
            getUserReverseGeocode(longitude: long, latitude: lat)
            
        }
    }
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        }
    }
    
    private func getUserReverseGeocode(longitude: Double, latitude: Double) {
        DispatchQueue.main.async {
            self.geocoder.reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { [weak self] (placemarks, error) in
                
                guard let self = self else { return }
                
                if let error = error {
                    print(error)
                    return
                }
                guard let placemark = placemarks?.first else { return }
                
                let locationString = "\(placemark.thoroughfare ?? "Street"), \(placemark.locality ?? "City"), \(placemark.subLocality ?? ""), \(placemark.subThoroughfare ?? ""), \(placemark.administrativeArea ?? "")"
                
                self.delegate?.showLocationString(locationString: locationString)
            }
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
   
    func getKitchens(){
        kitchens.removeAll()
        FirebaseEndpoints.kitchens.getDatabasePath.getData{ [weak self] (error, snapshot) in
            if let error = error {
                self?.delegate?.showAlert(message: "error")
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                
                if let kitchensDict = snapshot.value as? [String: Any] {
                    for kitchen in kitchensDict {
                        if let kitchenDetails = kitchen.value as? [String: Any] {
                            let kitchen = KitchenModel.getKitchenFromDict(kitchenDetails: kitchenDetails)
                            
                            self?.kitchens.append(kitchen)
                            
                        }
                    }
                }
                
                self?.delegate?.kitchensLoaded()
            }
            else {
                self?.delegate?.showAlert(message: "no data")
                print("No data available")
            }
        }
    }
    
    //    private func createRecipeModel(recipeDict: [String: Any]) {
    //
    //    }
}

// MARK: - Location Manager Delegate
extension HomePageViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
