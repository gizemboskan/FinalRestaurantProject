//
//  KitchensViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import UIKit

class KitchensViewController: UIViewController {
    // MARK: - Properties
    
    let viewModel: KitchensViewModel = KitchensViewModel()
    
    // MARK: - UI Components
    
    @IBOutlet weak var kitchenTableView: UITableView!
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kitchenTableView.delegate = self
        kitchenTableView.dataSource = self
        viewModel.delegate = self
        let nibCell = UINib(nibName: "KitchenCell", bundle: nil)
        kitchenTableView.register(nibCell, forCellReuseIdentifier: "KitchenCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getKitchens()
    }
    
    // MARK: - Helpers
}
// MARK: - UITableViewDataSource and Delegate
extension KitchensViewController:  UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.kitchens.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = kitchenTableView.dequeueReusableCell(withIdentifier: "KitchenCell", for: indexPath) as! KitchenCell
        let kitchenModel = viewModel.kitchens[indexPath.row]
        cell.kitchenTitle.text = kitchenModel.name
        cell.setImage(from: kitchenModel.imageURL)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Kitchen", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "KitchenDetailViewController") as? KitchenDetailViewController {
            vc.viewModel.kitchenID = viewModel.kitchens[indexPath.row].id
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}
// MARK: - KitchensViewModelDelegate
extension KitchensViewController: KitchensViewModelDelegate {
    func kitchensLoaded() {
        kitchenTableView.reloadData()
    }
    
    func showAlert(message: String) {
        
    }
    
    
}
