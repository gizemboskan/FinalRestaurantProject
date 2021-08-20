//
//  MyOrderViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 12.08.2021.
//

import UIKit
import StepIndicator
import MapKit

class MyOrderViewController: UIViewController {
    // MARK: - Properties
    let progress = Progress(totalUnitCount: 4)
    
    // MARK: - UI Components
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var downView: UIView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeArrivalTimeLabel: UILabel!
    @IBOutlet weak var stepIndicatorView: StepIndicatorView!
    @IBOutlet weak var sendedRequestLabel: UILabel!
    @IBOutlet weak var confirmedOrderLabel: UILabel!
    @IBOutlet weak var shipperReceivedLabel: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    @IBOutlet weak var receivedFoodLabel: UILabel!
    
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true

        mapView.mapType = .mutedStandard
        recipeImageView.roundCorners(.allCorners, radius: 40)
        recipeImageView.roundCorners(.allCorners, radius: 60)
        stepIndicatorView.currentStep = 0
        startCount()
    }
    
    // MARK: - Helpers
    
    private func startCount(){
        confirmedOrderLabel.textColor = UIColor(red: 255, green: 214, blue: 123, alpha: 1)
        shipperReceivedLabel.textColor = UIColor(red: 255, green: 214, blue: 123, alpha: 1)
        shippingLabel.textColor = UIColor(red: 255, green: 214, blue: 123, alpha: 1)
        receivedFoodLabel.textColor = UIColor(red: 255, green: 214, blue: 123, alpha: 1)
        
        Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { (timer) in
            guard self.progress.isFinished == false else {
                timer.invalidate()
                return
            }
            self.progress.completedUnitCount += 1
            
            if self.progress.completedUnitCount == 1 {
                self.stepIndicatorView.currentStep += 1
                self.confirmedOrderLabel.textColor = .label
            }else if self.progress.completedUnitCount == 2 {
                self.stepIndicatorView.currentStep += 1
                self.shipperReceivedLabel.textColor = .label
            }else if self.progress.completedUnitCount == 3 {
                self.stepIndicatorView.currentStep += 1
                self.shippingLabel.textColor = .label
            }else if self.progress.completedUnitCount == 4 {
                self.stepIndicatorView.currentStep += 1
                self.receivedFoodLabel.textColor = .label
            }
            
        }
    }
    
}


// MARK: - PaymentViewModelDelegate
