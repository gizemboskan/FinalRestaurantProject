//
//  PaymentViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import UIKit

class PaymentViewController: UIViewController {
    // MARK: - Properties
    
    let viewModel: PaymentViewModel = PaymentViewModel()
    
    // MARK: - UI Components
    
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var kitchenNameLabel: UILabel!
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    @IBOutlet weak var creditCardNumberTextField: UITextField!
    @IBOutlet weak var cashButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var creditCardCVCTextField: UITextField!
    @IBOutlet weak var creditCardDateTextField: UITextField!
    
    @IBOutlet weak var orderDoneImageView: UIImageView!
    @IBOutlet weak var orderSucceedView: UIView!
    @IBOutlet weak var goHomeButton: UIButton!
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        orderSucceedView.isHidden = true
        orderDoneImageView.isHidden = true
        
        cashButton.isHighlighted = false
        creditCardCVCTextField.isEnabled = true
        creditCardDateTextField.isEnabled = true
        creditCardNumberTextField.isEnabled = true
    }
    
    // MARK: - Helpers
    @IBAction func payButtonPressed(_ sender: UIButton) {
        orderSucceedView.isHidden = false
        orderDoneImageView.isHidden = true

    }
    
    @IBAction func cashButtonPressed(_ sender: UIButton) {
        cashButton.isHighlighted = true
        creditCardCVCTextField.isEnabled = false
        creditCardDateTextField.isEnabled = false
        creditCardNumberTextField.isEnabled = false
        
    }
    
    @IBAction func goHomeButtonPressed(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageViewController {
            vc.popoverPresentationController?.sourceView = sender as UIView
            vc.present(vc, animated: true)
    }
    }
}
