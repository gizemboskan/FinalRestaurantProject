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
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kitchenTableView.delegate = self
        kitchenTableView.dataSource = self
        searchBar.delegate = self
        kitchenTableView.restore()
        viewModel.delegate = self
        let nibCell = UINib(nibName: "KitchenCell", bundle: nil)
        kitchenTableView.register(nibCell, forCellReuseIdentifier: "KitchenCell")
        kitchenTableView.roundCorners(.allCorners, radius: 22)
        
       
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
        return viewModel.isFiltering ? viewModel.filteredKitchens.count : viewModel.kitchens.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = kitchenTableView.dequeueReusableCell(withIdentifier: "KitchenCell", for: indexPath) as! KitchenCell
        let kitchenModel = viewModel.isFiltering ? viewModel.filteredKitchens[indexPath.row] : viewModel.kitchens[indexPath.row]
        cell.kitchenDescs = kitchenModel.descriptions
        cell.kitchenTitle.text = kitchenModel.name
        cell.setImage(from: kitchenModel.imageURL)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Kitchen", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "KitchenDetailViewController") as? KitchenDetailViewController {
            vc.viewModel.kitchenID = viewModel.isFiltering ? viewModel.filteredKitchens[indexPath.row].id : viewModel.kitchens[indexPath.row].id
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}
// MARK: - SearchBar Delegate
extension KitchensViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let isEmpty = searchBar.text?.isEmpty, isEmpty, searchText.isEmpty{
            DispatchQueue.main.async {
                self.viewModel.isFiltering = false
                self.kitchenTableView.restore()
                self.kitchenTableView.reloadData()
                self.searchBar.resignFirstResponder()
                return
            }
        }

        viewModel.filterKitchen(by: searchText)

        DispatchQueue.main.async {
            self.kitchenTableView.reloadData()
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.isFiltering = false
        searchBar.text = ""
        kitchenTableView.reloadData()
        kitchenTableView.restore()
    }
}

// MARK: - KitchensViewModelDelegate
extension KitchensViewController: KitchensViewModelDelegate {
    func filteringApplied(isEmpty: Bool) {
        if isEmpty {
            kitchenTableView.setEmptyView(title: "Oops! Your search was not found.", message: "Search for another result!")
        }else {
            kitchenTableView.restore()
        }
    }
    
    func kitchensLoaded() {
        kitchenTableView.reloadData()
    }
    
    func showAlert(message: String) {
        
    }
}
