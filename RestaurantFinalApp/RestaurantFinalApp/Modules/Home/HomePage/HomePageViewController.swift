//
//  HomePageViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import UIKit
import MapKit

class HomePageViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: HomePageViewModelProtocol = HomePageViewModel()
    lazy var kitchenPageViewController: KitchenPageViewController = {
        return children.lazy.compactMap({ $0 as? KitchenPageViewController }).first!
    }()
    
    // MARK: - UI Components
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var kitchenTableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet var pageView: UIView!
    @IBOutlet weak var seeAllFavRecipesButton: UIButton!
    @IBOutlet weak var favRecipesCollectionView: UICollectionView!
    @IBOutlet weak var flowlayout: UICollectionViewFlowLayout!
    @IBOutlet weak var seeAllKitchensButton: UIButton!
    @IBOutlet weak var viewWithLocation: UIView!
    
    @IBOutlet weak var orderStatusButton: UIButton!
    @IBOutlet weak var favRecipeLabel: UILabel!
    @IBOutlet weak var kitchenTitleLabel: UILabel!
    @IBOutlet weak var nearbyKitchenLabel: UILabel!
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        viewModel.delegate = self
        viewModel.getUserLocation()
        
        favRecipesCollectionView.delegate = self
        favRecipesCollectionView.dataSource = self
        locationLabel.numberOfLines = 0 
        kitchenTableView.delegate = self
        
        kitchenTableView.dataSource = self
        kitchenTableView.roundCorners(.allCorners, radius: 22)
        profileImageView.roundCorners(.allCorners, radius: 4)
        pageView.roundCorners(.allCorners, radius: 15)
        favRecipesCollectionView.roundCorners(.allCorners, radius: 22)
        
        let nibCell = UINib(nibName: "KitchenCell", bundle: nil)
        kitchenTableView.register(nibCell, forCellReuseIdentifier: "KitchenCell")
        let nibRecipeCell = UINib(nibName: "FavRecipesCollectionViewCell", bundle: nil)
        favRecipesCollectionView.register(nibRecipeCell, forCellWithReuseIdentifier: "FavRecipesCollectionViewCell")
        kitchenTableView.roundCorners(.allCorners, radius: 22)
        viewWithLocation.roundCorners(.allCorners, radius: 20)
        setLocalizedTexts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getMyRecipes()
        viewModel.getKitchens()
        
        if viewModel.myRecipes.count > 5 {
            seeAllFavRecipesButton.isHidden = false
        }
        if viewModel.myRecipes.count > 5 {
            seeAllKitchensButton.isHidden = true
        }
        
    }
    
    // MARK: - Helpers
    private func setLocalizedTexts() {
        seeAllFavRecipesButton.setTitle("see_all".localized(), for: .normal)
        seeAllKitchensButton.setTitle("see_all".localized(), for: .normal)
        orderStatusButton.setTitle("order_status".localized(), for: .normal)
        favRecipeLabel.text = "your_fav_recipes".localized()
        kitchenTitleLabel.text = "kitchens_title".localized()
        nearbyKitchenLabel.text = "nearby_kitchens".localized()
    }
    
    @IBAction func seeAllFavRecipesButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Recipe", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "RecipesViewController") as? RecipesViewController {
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func orderStatusButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Order", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "MyOrderViewController") as? MyOrderViewController {
            present(vc, animated: true) {
                self.orderStatusButton.isHidden = true
            }
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
        return viewModel.myRecipes.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favRecipesCollectionView.dequeueReusableCell(withReuseIdentifier: "FavRecipesCollectionViewCell", for: indexPath) as! FavRecipesCollectionViewCell
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
        return CGSize(width: 135, height: 165)
    }
}



// MARK: - UITableViewDataSource and Delegate
extension HomePageViewController:  UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.kitchens.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = kitchenTableView.dequeueReusableCell(withIdentifier: "KitchenCell", for: indexPath) as! KitchenCell
        let kitchenModel = viewModel.kitchens[indexPath.row]
        cell.kitchenTitle.text = kitchenModel.name
        cell.ratingLabel.text = String(kitchenModel.rating)
        cell.delivertTimeLabel.text = kitchenModel.avarageDeliveryTime
        cell.ratingCountLabel.text = String(kitchenModel.ratingCount)
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
// MARK: - HomePageViewModelDelegate
extension HomePageViewController: HomePageViewModelDelegate {
    
    func showLocationString(locationString: String) {
        locationLabel.text = locationString
    }
    func kitchensLoaded() {
        kitchenTableView.reloadData()
    }
    
    func showAlert(message: String, title: String) {
        showAlertController(message: message, title: title)
    }
    
    func myRecipesLoaded() {
        favRecipesCollectionView.reloadData()
    }
    
    func showLoadingIndicator(isShown: Bool) {
        if isShown {
            startLoading()
        } else {
            stopLoading()
        }
    }
    
    func showOrderStatus() {
        orderStatusButton.isHidden = false
    }
}
