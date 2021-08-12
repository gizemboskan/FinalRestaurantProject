//
//  HomePageViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import UIKit

class HomePageViewController: UIViewController {
    // MARK: - Properties
    
    let viewModel: HomePageViewModel = HomePageViewModel()
    // MARK: - UI Components
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var kitchenTableView: UITableView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var pageView: UIView!
    @IBOutlet var seeAllFavRecipesButton: UIButton!
    @IBOutlet var favRecipesCollectionView: UICollectionView!
    
    @IBOutlet var flowlayout: UICollectionViewFlowLayout!
    @IBOutlet var seeAllKitchensButton: UIButton!
    lazy var restaurantPageViewController: KitchenPageViewController = {
        return children.lazy.compactMap({ $0 as? KitchenPageViewController }).first!
    }()
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        favRecipesCollectionView.delegate = self
        favRecipesCollectionView.dataSource = self
        
        kitchenTableView.delegate = self
        kitchenTableView.dataSource = self
        let nibCell = UINib(nibName: "KitchenCell", bundle: nil)
        kitchenTableView.register(nibCell, forCellReuseIdentifier: "KitchenCell")
    }
    
    // MARK: - Helpers
    @IBAction func seeAllFavRecipesButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Recipe", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "RecipesViewController") as? RecipesViewController {
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func seeAllKitchensButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Kitchen", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "KitchensViewController") as? KitchensViewController {
            
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

// MARK: - UICollectionViewDataSource and Delegate
extension HomePageViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favRecipesCollectionView.dequeueReusableCell(withReuseIdentifier: "FavRecipesCollectionViewCell", for: indexPath) as! FavRecipesCollectionViewCell
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Recipe", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as? RecipeDetailViewController {
            
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 165)
    }
}



// MARK: - UITableViewDataSource and Delegate
extension HomePageViewController:  UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
