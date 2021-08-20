//
//  LandingMenuViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 7.08.2021.
//

import UIKit

class LandingMenuViewController: UIViewController {
    
    let vievModel: LandingMenuViewModel = LandingMenuViewModel()
    
    
    @IBOutlet weak var yemeksepetiImageView: UIImageView!
    
    @IBOutlet weak var kitchenAppImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(self.handleTap(_:)))
        kitchenAppImageView.addGestureRecognizer(tap)
    }
    
    @IBAction func handleTap(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "LandingScreen", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "TutorialViewController") as? TutorialViewController {
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
