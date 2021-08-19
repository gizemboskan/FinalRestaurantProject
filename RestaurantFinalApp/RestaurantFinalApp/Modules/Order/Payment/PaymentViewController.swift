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
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var creditCardCVCTextField: UITextField!
    @IBOutlet weak var creditCardDateTextField: UITextField!
    
    @IBOutlet weak var orderDoneImageView: UIImageView!
    @IBOutlet weak var orderSucceedView: UIView!
    @IBOutlet weak var goHomeButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var viewWithPayButton: UIView!
    @IBOutlet weak var firstView: UIView!
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        orderSucceedView.isHidden = true
        creditCardCVCTextField.isEnabled = true
        creditCardDateTextField.isEnabled = true
        creditCardNumberTextField.isEnabled = true
        viewModel.getPaymentDetails()
        viewWithPayButton.roundCorners(.allCorners, radius: 35)
    }
    
    // MARK: - Helpers
    @IBAction func payButtonPressed(_ sender: UIButton) {
        orderSucceedView.isHidden = false

        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = scrollView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.scrollView.isScrollEnabled = false
        self.firstView.addSubview(blurEffectView)
    }
    
    @IBAction func goHomeButtonPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - PaymentViewModelDelegate

extension PaymentViewController: PaymentViewModelDelegate {
    func showAlert(message: String) {
        
    }
    
    func paymentDetailLoaded(kitchenName: String, recipeName: String, totalPrice: String) {
        kitchenNameLabel.text = kitchenName
        recipeNameLabel.text = recipeName
        priceLabel.text = totalPrice
    }
}
