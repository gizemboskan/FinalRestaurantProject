//
//  HomePageViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import Foundation
import Firebase
import MapKit

protocol HomePageViewModelProtocol {
    var delegate: HomePageViewModelDelegate? { get set }
    var myRecipes: [RecipeModel] { get set }
    var activeOrder: RecipeModel? { get set }
    var kitchens: [KitchenModel] { get set }
    func getMyRecipes()
    func getUserLocation()
    func getKitchens()
}

protocol HomePageViewModelDelegate: AnyObject {
    func showAlert(message: String, title: String)
    func showLoadingIndicator(isShown: Bool)
    func myRecipesLoaded() // signal to view layer to say "I loaded the datas, and you can take an action."
    func kitchensLoaded()
    func showLocationString(locationString: String)
    func showOrderStatus()
}

final class HomePageViewModel: NSObject {
    
    // MARK: - Properties

    weak var delegate: HomePageViewModelDelegate?
    var myRecipes: [RecipeModel] = []
    var activeOrder: RecipeModel?
    var kitchens: [KitchenModel] = []

    let locationManager = CLLocationManager()
    var userLocation: CLLocation?
    
    private var myUserDetail: UserModel?
    private lazy var geocoder = CLGeocoder()
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveOrder(_:)), name: .orderActivated, object: nil)

    }

    @objc func onDidReceiveOrder(_ notification: Notification) {
        if let recipe = notification.userInfo?["recipe"] as? RecipeModel {
            activeOrder = recipe
            delegate?.showOrderStatus()
        }
    }
    
    // MARK: - Helpers
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
                
                var locationString = ""
                if let thoroughfare = placemark.thoroughfare {
                    locationString += thoroughfare + ", "
                }
                if let locality = placemark.locality {
                    locationString += locality + ", "
                }
                if let subLocality = placemark.subLocality {
                    locationString += subLocality + ", "
                }
                if let subThoroughfare = placemark.subThoroughfare {
                    locationString += subThoroughfare + ", "
                }
                if let administrativeArea = placemark.administrativeArea {
                    locationString += administrativeArea
                }

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
            getLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways:
            getLocation()
        case .restricted:
            break
        }
    }
    
    private func getLocation() {
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
}

// MARK: - Accessors
extension HomePageViewModel: HomePageViewModelProtocol {
    func getMyRecipes() {
        delegate?.showLoadingIndicator(isShown: true)
        FirebaseEndpoints.myUser.getDatabasePath.child("recipes").getData{ [weak self] (error, snapshot) in
            self?.delegate?.showLoadingIndicator(isShown: false)
            if let error = error {
                self?.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
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
                    
                    self?.myRecipes.removeAll()
                    self?.myRecipes = Array(tempRecipes.prefix(5))
                }
                
                self?.delegate?.myRecipesLoaded()
            }
            else {
                self?.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
                print("No data available")
            }
        }
    }
    
    func getUserLocation() {
        checkLocationServices()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getKitchens() {
        delegate?.showLoadingIndicator(isShown: true)
        FirebaseEndpoints.kitchens.getDatabasePath.getData{ [weak self] (error, snapshot) in
            self?.delegate?.showLoadingIndicator(isShown: false)
            if let error = error {
                self?.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                
                self?.kitchens.removeAll()
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
                self?.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
                print("No data available")
            }
        }
    }
    
}

// MARK: - Location Manager Delegate
extension HomePageViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
