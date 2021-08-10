//
//  SeconBarItemViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 10.08.2021.
//

import UIKit

class SecondBarItemViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "CreateRecipe", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CreateRecipeViewController")
        
        setViewControllers([vc], animated: false)
    }
}
