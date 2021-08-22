//
//  ThirdTabBarItemViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 21.08.2021.
//

import UIKit

class ThirdTabBarItemViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "Kitchen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "KitchenLocationsViewController")
        
        setViewControllers([vc], animated: false)
    }
}

