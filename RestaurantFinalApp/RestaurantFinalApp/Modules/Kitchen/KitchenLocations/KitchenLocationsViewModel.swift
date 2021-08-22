//
//  KitchenLocationsViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 21.08.2021.
//

import Foundation


import Firebase
import MapKit

protocol KitchenLocationsViewModelDelegate: AnyObject {
    func showAlert(message: String, title: String)
    func showLoadingIndicator(isShown: Bool)
    func kitchensLoaded()
    func zoomRegion(region: MKCoordinateRegion)
}

protocol KitchenLocationsViewModelProtocol {
    var delegate: KitchenLocationsViewModelDelegate? { get set }
    var kitchens: [KitchenModel] { get set }
    func getKitchens()
}

final class KitchenLocationsViewModel: NSObject {
    weak var delegate: KitchenLocationsViewModelDelegate?
    var kitchens: [KitchenModel] = []
    
    private let locationManager = CLLocationManager()

    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        }
    }
    
    private func setMapVisibleRegion(longitude: Double, latitude: Double) {
        let latDelta:CLLocationDegrees = 0.05
        let lonDelta:CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let lat:CLLocationDegrees = latitude
        let long:CLLocationDegrees = longitude
        let location = CLLocation(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        
        self.delegate?.zoomRegion(region: region)
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
    
    private func getUserLocation() {
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
        }
    }
}

// MARK: - Location Manager Delegate
extension KitchenLocationsViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

extension KitchenLocationsViewModel: KitchenLocationsViewModelProtocol {
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
                
                if let kitchensDict = snapshot.value as? [String: Any] {
                    self?.kitchens.removeAll()
                    for kitchen in kitchensDict {
                        if let kitchenDetails = kitchen.value as? [String: Any] {
                            let kitchen = KitchenModel.getKitchenFromDict(kitchenDetails: kitchenDetails)
                            
                            self?.kitchens.append(kitchen)
                        }
                    }
                }
                
                self?.delegate?.kitchensLoaded()
                self?.getUserLocation()
            }
            else {
                self?.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
                print("No data available")
            }
        }
    }
}
