//
//  KitchensViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import UIKit

class KitchensViewController: UIViewController {
    
    @IBOutlet var kitchenTableView: UITableView!
    let viewModel: KitchensViewModel = KitchensViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        kitchenTableView.delegate = self
        kitchenTableView.dataSource = self
        let nibCell = UINib(nibName: "KitchenCell", bundle: nil)
        kitchenTableView.register(nibCell, forCellReuseIdentifier: "KitchenCell")
    }
}
// MARK: - UITableViewDataSource and Delegate
extension KitchensViewController:  UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = kitchenTableView.dequeueReusableCell(withIdentifier: "KitchenCell", for: indexPath) as! KitchenCell
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Kitchen", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "KitchenDetailViewController") as? KitchenDetailViewController {
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
