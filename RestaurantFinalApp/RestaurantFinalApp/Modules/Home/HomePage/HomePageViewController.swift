//
//  HomePageViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import UIKit

class HomePageViewController: UIViewController {

    let viewModel: HomePageViewModel = HomePageViewModel()
    
    @IBOutlet var kitchenTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibCell = UINib(nibName: "KitchenCell", bundle: nil)
        kitchenTableView.register(nibCell, forCellReuseIdentifier: "KitchenCell")
        // Do any additional setup after loading the view.
    }
    // let cell = kitchenTableView.dequeueReusableCell(withReuseIdentifier: "KitchenCell", for: indexPath) as! KitchenCell
}
