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
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
        viewModel.delegate = self
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
        return viewModel.myRecipes.count
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recipesCollectionView.dequeueReusableCell(withReuseIdentifier: "FavRecipesCollectionViewCell", for: indexPath) as! FavRecipesCollectionViewCell
        let recipeModel = viewModel.myRecipes[indexPath.row]
        cell.favRecipeName.text = recipeModel.name
        cell.setImage(from: recipeModel.imageURL)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Recipe", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as? RecipeDetailViewController {
            vc.viewModel.recipeID = viewModel.myRecipes[indexPath.row].id
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 210)
    }
}

// MARK: - RecipesViewModelDelegate
extension RecipesViewController: RecipesViewModelDelegate {
    
    func showAlert(message: String) {
        
    }
    
    func myRecipesLoaded() {
        recipesCollectionView.reloadData()
    }
}
