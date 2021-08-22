//
//  RecipeDetailViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import UIKit
import WSTagsField
class RecipeDetailViewController: UIViewController {
    // MARK: - Properties
    
    
    var viewModel: RecipeDetailViewModelProtocol = RecipeDetailViewModel()
    
    // MARK: - UI Components
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeEditButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var recipeTextView: UITextView!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var tagsField: WSTagsField!
    
    @IBOutlet weak var createRecipeView: UIView!
    
    @IBOutlet weak var viewWithButton: UIView!
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        viewModel.delegate = self
        viewWithButton.roundCorners(.allCorners, radius: 20)
        setTagsFieldProperties()
        recipeTextView.roundCorners(.allCorners, radius: 3)
        createRecipeView.roundCorners([.topLeft, .topRight], radius: 20)
        tagsField.isUserInteractionEnabled = false
        setLocalizedTexts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getDetails()
        hideKeyboardWhenTappedAround()
    }
    // MARK: - Helpers
    @IBAction func backButtonPressed(_ sender: UIButton) {
        viewModel.quitView()
    }
    
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            firstView.isHidden = false
            secondView.isHidden = true
        case 1:
            firstView.isHidden = true
            secondView.isHidden = false
        default:
            break
        }
    }
    
    @IBAction func favButtonPressed(_ sender: Any) {
        viewModel.showFavAlert()
        
    }
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        viewModel.shareRecipe()
    }
    
    @IBAction func recipeEditButtonTapped(_ sender: Any) {
        viewModel.editRecipe()
    }
    @IBAction func orderButtonPressed(_ sender: UIButton) {
        viewModel.orderRecipe()
        
    }
    
    private func setLocalizedTexts() {
        orderButton.setTitle("order".localized(), for: .normal)
    }
    
    private func setTagsFieldProperties(){
        tagsField.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        tagsField.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tagsField.spaceBetweenLines = 5.0
        tagsField.spaceBetweenTags = 10.0
        tagsField.font = .systemFont(ofSize: 12.0)
        tagsField.backgroundColor = .white
        tagsField.tintColor = .systemOrange
        tagsField.textColor = .black
        tagsField.textField.textColor = .blue
        tagsField.selectedColor = .black
        tagsField.selectedTextColor = .red
        tagsField.delimiter = "--"
        tagsField.isDelimiterVisible = false
        tagsField.placeholder = ""
        tagsField.placeholderColor = .systemOrange
        tagsField.placeholderAlwaysVisible = true
        tagsField.keyboardAppearance = .dark
        tagsField.textField.returnKeyType = .next
        tagsField.acceptTagOption = .return
        tagsField.shouldTokenizeAfterResigningFirstResponder = true
        
        // Events
        tagsField.onDidAddTag = { field, tag in
            print("DidAddTag", tag.text)
        }
        
        tagsField.onDidRemoveTag = { field, tag in
            print("DidRemoveTag", tag.text)
        }
        
        tagsField.onDidChangeText = { _, text in
            print("DidChangeText")
        }
        
        tagsField.onDidChangeHeightTo = { _, height in
            print("HeightTo", height)
        }
        
        tagsField.onValidateTag = { tag, tags in
            // custom validations, called before tag is added to tags list
            return tag.text != "#" && !tags.contains(where: { $0.text.uppercased() == tag.text.uppercased() })
        }
        
        print("List of Tags Strings:", tagsField.tags.map({$0.text}))
    }
}

// MARK: - RecipeDetailViewModelDelegate

extension RecipeDetailViewController: RecipeDetailViewModelDelegate{
    
    func showAlert(message: String, title: String) {
        showAlertController(message: message, title: title)
    }
    
    func showLoadingIndicator(isShown: Bool) {
        if isShown {
            startLoading()
        } else {
            stopLoading()
        }
    }
    
    func editRecipeButtonPressed() {
        let storyboard = UIStoryboard(name: "CreateRecipe", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "CreateRecipeViewController") as? CreateRecipeViewController {
            vc.viewModel.recipeToEdit = viewModel.recipeDetail
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func favProcessCompleted(favStateImage: String) {
        self.favButton.setImage(UIImage(named: favStateImage), for: .normal)
    }
    
    func askForFav(isFav: Bool) {
        if !isFav {
            let vc = UIAlertController(title: "save_fav".localized(), message: "choose_path".localized(), preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "wonderful".localized(), style: .default, handler: { UIAlertAction in
                self.viewModel.changeFavorite()
            }))
            vc.addAction(UIAlertAction(title: "need_think".localized(), style: .cancel))
            present(vc, animated: true)
            
        } else {
            let vc = UIAlertController(title: "make_unfav".localized(), message: "choose_path".localized(), preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "unfav".localized(), style: .default, handler: { UIAlertAction in
                self.viewModel.changeFavorite()
            }))
            vc.addAction(UIAlertAction(title: "need_think".localized(), style: .cancel))
            present(vc, animated: true)
        }
    }
    
    func shareButtonPressed() {
        let vc = UIActivityViewController(activityItems: ["share_recipe".localized()] , applicationActivities: [])
        vc.popoverPresentationController?.sourceView = self.view
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
        self.navigationController?.popViewController(animated: true)
    }
    
    func orderButtonPressed() {
        
        let vc = UIAlertController(title: "get_offer".localized(), message: "get_offer_desc".localized(), preferredStyle: .alert)
        
        vc.addAction(UIAlertAction(title: "get_offer".localized(), style: .default, handler: { UIAlertAction in
                                    
                                    let storyboard = UIStoryboard(name: "Order", bundle: nil)
                                    if let vc = storyboard.instantiateViewController(withIdentifier: "GetOfferViewController") as? GetOfferViewController {
                                        vc.viewModel.recipeModel = self.viewModel.recipeDetail
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    } }))
        
        vc.addAction(UIAlertAction(title: "not_sure".localized(), style: .cancel))
        present(vc, animated: true)
    }
    
    
    func instructionLoaded(instruction: String) {
        recipeTextView.text = viewModel.recipeDetail?.instruction
    }
    
    func ingredientsLoaded(ingredients: [String]) {
        
        tagsField.addTags(ingredients)
    }
    
    func titleLoaded(title: String) {
        recipeNameLabel.text = title
    }
    func imageLoaded(image: String) {
        guard let imageUrl:URL = URL(string: viewModel.recipeDetail?.imageURL ?? "") else {return}
        recipeImageView.loadImage(withUrl: imageUrl)
    }
    
}
