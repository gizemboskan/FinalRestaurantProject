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
    let verticalProgressView: VerticalProgressView = {
        let progressView = VerticalProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    let progress = Progress(totalUnitCount: 5)
    
    
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
        downView.roundCorners([.topLeft, .topRight], radius: 30)
        recipeImageView.roundCorners(.allCorners, radius: 140)
        verticalProgressView.progress = 0.0
        let verticalProgressView = VerticalProgressView(frame: CGRect(x: 8, y: 173, width: 6, height: 170))
        view.addSubview(verticalProgressView)
        verticalProgressView.setProgress(0.4, animated: false)
        verticalProgressView.isAscending = true
        verticalProgressView.progressTintColor = .label
        verticalProgressView.progressViewStyle = .bar
        verticalProgressView.trackTintColor = UIColor(red: 255, green: 214, blue: 123, alpha: 1)
        recipeImageView.roundCorners(.allCorners, radius: 60)
        startCount()
        
    }
    
    // MARK: - Helpers
    
    //    private func addVerticalProgressView() {
    //        view.addSubview(verticalProgressView)
    //        verticalProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    //        verticalProgressView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    //        verticalProgressView.widthAnchor.constraint(equalToConstant: 6).isActive = true
    //        verticalProgressView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
    //    }
    
    
    private func startCount(){
        sendedRequestLabel.tintColor = UIColor(red: 255, green: 214, blue: 123, alpha: 1)
        confirmedOrderLabel.tintColor = UIColor(red: 255, green: 214, blue: 123, alpha: 1)
        shipperReceivedLabel.tintColor = UIColor(red: 255, green: 214, blue: 123, alpha: 1)
        shippingLabel.tintColor = UIColor(red: 255, green: 214, blue: 123, alpha: 1)
        receivedFoodLabel.tintColor = UIColor(red: 255, green: 214, blue: 123, alpha: 1)
        
        Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { (timer) in
            guard self.progress.isFinished == false else {
                timer.invalidate()
                return
            }
            self.progress.completedUnitCount += 1
            self.verticalProgressView.setProgress(Float(self.progress.fractionCompleted), animated: true)
            if self.progress.completedUnitCount == 1{
                self.sendedRequestLabel.tintColor = .label
            } else if self.progress.completedUnitCount == 2{
                self.sendedRequestLabel.tintColor = .label
                self.confirmedOrderLabel.tintColor = .label
            }else if self.progress.completedUnitCount == 3{
                self.sendedRequestLabel.tintColor = .label
                self.confirmedOrderLabel.tintColor = .label
                self.shipperReceivedLabel.tintColor = .label
            }else if self.progress.completedUnitCount == 4{
                self.sendedRequestLabel.tintColor = .label
                self.confirmedOrderLabel.tintColor = .label
                self.shipperReceivedLabel.tintColor = .label
                self.shippingLabel.tintColor = .label
            }else if self.progress.completedUnitCount == 5{
                self.sendedRequestLabel.tintColor = .label
                self.confirmedOrderLabel.tintColor = .label
                self.shipperReceivedLabel.tintColor = .label
                self.shippingLabel.tintColor = .label
                self.receivedFoodLabel.tintColor = .label
            }
            
        }
    }
    
}


// MARK: - PaymentViewModelDelegate
