//
//  RecipesViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import UIKit

class RecipesViewController: UIViewController {
    // MARK: - Properties
    
    let viewModel: RecipesViewModel = RecipesViewModel()
    
    // MARK: - UI Components
    @IBOutlet weak var recipesCollectionView: UICollectionView!
    @IBOutlet weak var flowlayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
        recipesCollectionView.restore()
        
        searchBar.delegate = self
        recipesCollectionView.restore()
        viewModel.delegate = self
        hideKeyboardWhenTappedAround()
        recipesCollectionView.roundCorners(.allCorners, radius: 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getMyRecipes()
    }
    
    // MARK: - Helpers
    
    
    
}
// MARK: - UICollectionViewDataSource and Delegate
extension RecipesViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.isFiltering ? viewModel.filteredRecipes.count : viewModel.myRecipes.count
        
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recipesCollectionView.dequeueReusableCell(withReuseIdentifier: "FavRecipesCollectionViewCell", for: indexPath) as! FavRecipesCollectionViewCell
        let recipeModel = viewModel.isFiltering ? viewModel.filteredRecipes[indexPath.row] : viewModel.myRecipes[indexPath.row]
        cell.favRecipeName.text = recipeModel.name
        cell.setImage(from: recipeModel.imageURL)
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Recipe", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as? RecipeDetailViewController {
            vc.viewModel.recipeID = viewModel.isFiltering ? viewModel.filteredRecipes[indexPath.row].id : viewModel.myRecipes[indexPath.row].id
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 210)
    }
}
// MARK: - SearchBar Delegate
extension RecipesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let isEmpty = searchBar.text?.isEmpty, isEmpty, searchText.isEmpty{
            DispatchQueue.main.async {
                self.viewModel.isFiltering = false
                self.recipesCollectionView.restore()
                self.recipesCollectionView.reloadData()
                self.searchBar.resignFirstResponder()
                return
            }
        }
        
        viewModel.filterRecipe(by: searchText)
        
        DispatchQueue.main.async {
            self.recipesCollectionView.reloadData()
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.isFiltering = false
        searchBar.text = ""
        recipesCollectionView.reloadData()
        recipesCollectionView.restore()
    }
}
// MARK: - RecipesViewModelDelegate
extension RecipesViewController: RecipesViewModelDelegate {
    
    func filteringApplied(isEmpty: Bool) {
        if isEmpty {
            recipesCollectionView.setEmptyView(title: "Oops! Your search was not found.", message: "Search for another result!")
        }else {
            recipesCollectionView.restore()
        }
        
    }
    
    func showAlert(message: String) {
        
    }
    
    func myRecipesLoaded() {
        recipesCollectionView.reloadData()
    }
}
