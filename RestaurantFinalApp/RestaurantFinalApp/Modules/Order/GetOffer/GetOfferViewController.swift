//
//  GetOfferViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 13.08.2021.
//

import UIKit

class GetOfferViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet var availableKitchensTableView: UITableView!
    
    let viewModel: GetOfferViewModel = GetOfferViewModel()
    // MARK: - UI Components
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        availableKitchensTableView.dataSource = self
        availableKitchensTableView.delegate = self
    }
    
    // MARK: - Helpers
    
}

// MARK: - UITableViewDataSource and Delegate
extension GetOfferViewController:  UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = availableKitchensTableView.dequeueReusableCell(withIdentifier: "AvailableKitchensCell", for: indexPath) as! AvailableKitchensCell
        return cell
    }
}

