//
//  RecipeDetailViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var recipeNameLabel: UILabel!
    @IBOutlet var recipeIntroductionLabel: UILabel!
    @IBOutlet var recipeIntroductionTextView: UITextView!
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var ingredientsLabel: UILabel!
    @IBOutlet var favButton: UIButton!
    
    @IBOutlet var ingredientsTextView: UITextView!
    @IBOutlet var orderButton: UIButton!
    let viewModel: RecipeDetailViewModel = RecipeDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        // önceki ekrana dönsün
    }
    
    @IBAction func favButtonPressed(_ sender: UIButton) {
        // fav ekle - çıkar yap 
    }
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        let ac = UIAlertController(title: "Share!", message: "", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Share!", style: .default))
        present(ac, animated: true)
    }
    @IBAction func orderButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Order", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "GetOfferViewController") as? GetOfferViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
       
    }
}
