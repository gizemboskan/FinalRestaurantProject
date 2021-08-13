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
    }
    // MARK: - Helpers
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
            {
            case 0:
                recipeTextView.text = "Instructions Selected"
            case 1:
                recipeTextView.text = "Ingredients Selected"
            default:
                break
            }
    }
    @IBAction func favButtonPressed(_ sender: UIButton) {
        // fav ekle - çıkar yap 
    }
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        
        let vc = UIActivityViewController(activityItems: ["Share this great recipe with your loved ones! :)\n Or just save!"] , applicationActivities: [])
        vc.popoverPresentationController?.sourceView = sender as UIView
        present(vc, animated: true)
        
        vc.completionWithItemsHandler = {(_, completed, _, _) in
            if !completed {
                return
            }
            // User completed activity
        
            vc.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func orderButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Order", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "GetOfferViewController") as? GetOfferViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
       
    }
}
