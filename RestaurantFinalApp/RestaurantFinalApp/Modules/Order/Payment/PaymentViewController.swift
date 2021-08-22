//
//  PaymentViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import UIKit

class PaymentViewController: UIViewController {
    // MARK: - Properties
    
    var viewModel: PaymentViewModelProtocol = PaymentViewModel()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideKeyboardWhenTappedAround()
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
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
        viewModel.completePayment()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        viewModel.quitView()
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if (creditCardDateTextField.isFirstResponder || creditCardCVCTextField.isFirstResponder || creditCardCVCTextField.isFirstResponder) && view.frame.origin.y == 0 {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keybordWillHide(_ notification:Notification) {
        if (creditCardDateTextField.isFirstResponder || creditCardCVCTextField.isFirstResponder || creditCardCVCTextField.isFirstResponder)  && view.frame.origin.y != 0{
            view.frame.origin.y = 0
        }
    }
    
    @objc func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keybordWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - PaymentViewModelDelegate

extension PaymentViewController: PaymentViewModelDelegate {
    func paymentDetailLoaded(kitchenName: String, recipeName: String, totalPrice: String) {
        kitchenNameLabel.text = kitchenName
        recipeNameLabel.text = recipeName
        priceLabel.text = totalPrice
    }
    
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}
