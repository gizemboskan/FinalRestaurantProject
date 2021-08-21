//
//  KitchenLocationsViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 21.08.2021.
//

import UIKit
import MapKit
class KitchenLocationsViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel: KitchenLocationsViewModel = KitchenLocationsViewModel()
    var kitchenLocationPins : [MKPointAnnotation] = []
    let locationManager = CLLocationManager()
    
    
    // MARK: - UI Components
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet weak var refreshButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        viewModel.getKitchens()
        getAnnotations()
    }
    
    //  Helpers
    
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        mapView.removeAnnotations(kitchenLocationPins)
        kitchenLocationPins.removeAll()
        viewModel.getKitchens()
    }
    private func getAnnotations(){
        if !viewModel.kitchens.isEmpty {
            for kitchen in viewModel.kitchens {
                let lat = CLLocationDegrees(kitchen.latitude)
                let long = CLLocationDegrees(kitchen.longitude)
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let kitchenName = kitchen.name
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(kitchenName)"
                annotation.subtitle = "\(kitchen.id)"
                
                
                self.kitchenLocationPins.append(annotation)
            }
            DispatchQueue.main.async {
                self.mapView.addAnnotations(self.kitchenLocationPins)
            }
        }
    }
}
// MARK: - MKMapViewDelegate
extension KitchenLocationsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "Pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = btn
        }else {
            pinView?.annotation = annotation
        }
        pinView?.pinTintColor = .purple
        pinView?.tintColor = .purple
        pinView?.image = UIImage(named: "map_pin")
        
        return pinView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //                if control == view.rightCalloutAccessoryView {
        //
        //
        //
        //                    if let kitchenId = view.annotation?.subtitle{
        //                        let storyboard = UIStoryboard(name: "Kitchen", bundle: nil)
        //                        if let vc = storyboard.instantiateViewController(withIdentifier: "KitchenDetailViewController") as? KitchenDetailViewController {
        //                            vc.viewModel.kitchenID = viewModel.kitchens.allSatisfy(kitchenId == ) : viewModel.kitchens[indexPath.row].id
        //                            navigationController?.pushViewController(vc, animated: true)
        //                        }
        //
        //                        }
        //                    }
    }
}



// MARK: - KitchenLocationsViewModelDelegate
extension KitchenLocationsViewController: KitchenLocationsViewModelDelegate {
    func showAlert(message: String) {
        
    }
    
    func kitchensLoaded() {
        //mapView.addAnnotation(kitchenLocationPins as! MKAnnotation)
      
    }
}
