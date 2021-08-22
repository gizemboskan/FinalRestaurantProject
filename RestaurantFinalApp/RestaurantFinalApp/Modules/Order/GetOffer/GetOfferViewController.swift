//
//  GetOfferViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 13.08.2021.
//

import UIKit

class GetOfferViewController: UIViewController {
        
    // MARK: - Properties
    @IBOutlet weak var availableKitchensTableView: UITableView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: GetOfferViewModelProtocol = GetOfferViewModel()
    // MARK: - UI Components
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalizedTexts()
        availableKitchensTableView.dataSource = self
        availableKitchensTableView.delegate = self
        availableKitchensTableView.roundCorners(.allCorners, radius: 22)
        viewModel.delegate = self
        viewModel.getKitchens()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        viewModel.quitView()
    }
    
    // MARK: - Helpers
    private func setLocalizedTexts() {
        descriptionLabel.text = "order_list_desc".localized()
    }
}

// MARK: - UITableViewDataSource and Delegate
extension GetOfferViewController:  UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.kitchens.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = availableKitchensTableView.dequeueReusableCell(withIdentifier: "AvailableKitchensCell", for: indexPath) as! AvailableKitchensCell
        
        cell.availableKitchenNameLabel.text = viewModel.kitchens[indexPath.row].name
        let formattedAmount = String(format: "%.2f", viewModel.mockedAmounts[indexPath.row])
        cell.offerLabel.text = "$\(formattedAmount)"
        cell.deliveryTimeLabel.text = viewModel.kitchens[indexPath.row].avarageDeliveryTime
        cell.ratingLabel.text = String(viewModel.kitchens[indexPath.row].rating)
        cell.ratingCountLabel.text = String(viewModel.kitchens[indexPath.row].ratingCount)
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

// MARK: - GetOfferViewModelDelegate
extension GetOfferViewController: GetOfferViewModelDelegate {
    func showAlert(message: String, title: String) {
        showAlertController(message: message, title: title)
    }
    
    func showLoadingIndicator(isShown: Bool) {
        if isShown {
            startLoading()
        } else {
            stopLoading()
        }
    }
    
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func kitchensLoaded() {
        availableKitchensTableView.reloadData()
    }
}
