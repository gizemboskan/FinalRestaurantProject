//
//  GetOfferViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 13.08.2021.
//

import UIKit

class GetOfferViewController: UIViewController {
    
    // TODO add desc label on top of the page.
    
    // MARK: - Properties
    @IBOutlet var availableKitchensTableView: UITableView!
    
    let viewModel: GetOfferViewModel = GetOfferViewModel()
    // MARK: - UI Components
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        availableKitchensTableView.dataSource = self
        availableKitchensTableView.delegate = self
        viewModel.delegate = self
        viewModel.getKitchens()
    }
    
    // MARK: - Helpers
    
}

// MARK: - UITableViewDataSource and Delegate
extension GetOfferViewController:  UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.kitchens.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = availableKitchensTableView.dequeueReusableCell(withIdentifier: "AvailableKitchensCell", for: indexPath) as! AvailableKitchensCell
        
        cell.availableKitchenNameLabel.text = viewModel.kitchens[indexPath.row].name
        cell.offerLabel.text = "$\(viewModel.mockedAmounts[indexPath.row])"
        // TODO add other values to cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Order", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController {
            vc.viewModel.recipeModel = viewModel.recipeModel
            vc.viewModel.kitchen = viewModel.kitchens[indexPath.row]
            vc.viewModel.amount = viewModel.mockedAmounts[indexPath.row]

            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension GetOfferViewController: GetOfferViewModelDelegate {
    func showAlert(message: String) {
        
    }
    
    func kitchensLoaded() {
        availableKitchensTableView.reloadData()
    }
}
