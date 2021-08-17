//
//  RecipeDetailViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - UI Components
    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var recipeNameLabel: UILabel!
    
    @IBOutlet weak var recipeEditButton: UIButton!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var favButton: UIButton!
    
    @IBOutlet var recipeTextView: UITextView!
    @IBOutlet var orderButton: UIButton!
    
    let viewModel: RecipeDetailViewModel = RecipeDetailViewModel()
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getRecipeDetails()
    }
    // MARK: - Helpers
    @IBAction func backButtonPressed(_ sender: UIButton) {
        viewModel.quitView()
    }
    
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
        viewModel.changeSegmentStates(state: sender.selectedSegmentIndex)
    }
    @IBAction func favButtonPressed(_ sender: Any) {
        viewModel.changeFavorite()
    }
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        viewModel.shareRecipe(sender)
        
    }
    
    @IBAction func recipeEditButtonTapped(_ sender: Any) {
        viewModel.editRecipe()
    }
    @IBAction func orderButtonPressed(_ sender: UIButton) {
        viewModel.orderRecipe()
        
    }
}

extension RecipeDetailViewController: RecipeDetailViewModelDelegate{
    
    func editRecipeButtonPressed() {
        let storyboard = UIStoryboard(name: "CreateRecipe", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "CreateRecipeViewController") as? CreateRecipeViewController {
            vc.viewModel.recipeToEdit = viewModel.recipeDetail
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func favProcessCompleted(favStateImage: String) {
        favButton.setImage(UIImage(named: favStateImage), for: .normal)
    }
    
    func shareButtonPressed(_ sender: Any) {
        let vc = UIActivityViewController(activityItems: ["Share this great recipe with your loved ones! :)\n Or just save!"] , applicationActivities: [])
        vc.popoverPresentationController?.sourceView = sender as? UIView
        present(vc, animated: true)
        
        vc.completionWithItemsHandler = {(_, completed, _, _) in
            if !completed {
                return
            }
            // User completed activity
            
            vc.dismiss(animated: true, completion: nil)
        }
    }
    
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func orderButtonPressed() {
        let storyboard = UIStoryboard(name: "Order", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "GetOfferViewController") as? GetOfferViewController {
            vc.viewModel.recipeModel = viewModel.recipeDetail
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func instructionLoaded(instruction: String) {
        recipeTextView.text = viewModel.recipeDetail?.instruction
    }
    
    func ingredientsLoaded(ingredients: [String]) {
        recipeTextView.text = viewModel.recipeDetail?.ingredients.joined(separator: " ")
    }
    
    func showAlert(message: String) {
        
    }
    
    func titleLoaded(title: String) {
        recipeNameLabel.text = title
    }
    func imageLoaded(image: String) {
        guard let imageUrl:URL = URL(string: viewModel.recipeDetail?.imageURL ?? "") else {return}
        recipeImageView.loadImage(withUrl: imageUrl)
    }
    
    
}
