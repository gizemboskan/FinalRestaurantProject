//
//  CreateRecipeViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import UIKit

class CreateRecipeViewController: UIViewController, UINavigationControllerDelegate {
    // MARK: - Properties
    let viewModel: CreateRecipeViewModel = CreateRecipeViewModel()

    // MARK: - UI ComponentsUT
    @IBOutlet weak var recipeImagePickerView: UIImageView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet var firstView: UIView!
    @IBOutlet var secondView: UIView!
    @IBOutlet weak var imagePickerButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var recipeNameField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var ingredientsCollectionView: UICollectionView!
    @IBOutlet weak var flowlayout: UICollectionViewFlowLayout!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var editRecipeButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        viewModel.delegate = self
        ingredientsTextView.delegate = self
        instructionsTextView.delegate = self
        recipeNameField.delegate = self
        viewModel.editArrivedRecipe()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideKeyboardWhenTappedAround()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Helpers
    @IBAction func shareButtonTapped(_ sender: UIButton) {
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
    @IBAction func imagePickerButtonTapped(_ sender: UIButton) {
        let vc = UIAlertController(title: "Picure Selection", message: "Please pick a picture for your meal!", preferredStyle: .actionSheet)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
        }
        vc.addAction(cancelButton)
        let cameraButton = UIAlertAction(title: "Use Camera", style: .default) { UIAlertAction in
            self.pickImage(sourceType: .camera)
        }
        vc.addAction(cameraButton)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        let albumButton = UIAlertAction(title: "Use Photo Library", style: .default) { UIAlertAction in
            self.pickImage(sourceType: .photoLibrary)
        }
        vc.addAction(albumButton)
        present(vc, animated: true)
        // pop ile seçenek yaptır camero or albume yönlendir.
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
    
    // TODO REMOVE
    @IBAction func editRecipeButtonTapped(_ sender: UIButton) {
        ///   recipeTextView.isEditable = true
        // butonun state'ini burada değiştir!
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        
        // burada alert controller ile alertte geri dönmek istediğinizden emin misiniz datalar kaydedilmedi desin! OK ise;
        viewModel.quitView()
    }
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        viewModel.doneEditing(title: recipeNameField.text ?? "", image: recipeImagePickerView.image?.pngData() ?? Data(), instruction: instructionsTextView.text, ingredients: ingredientsTextView.text)
    }
    private func pickImage(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    @objc func pickAnImageFromAlbum(_ sender: Any) {
        pickImage(sourceType: .photoLibrary)
    }
    
    @objc func pickAnImageFromCamera(_ sender: Any) {
        pickImage(sourceType: .camera)
    }
    private func setDefaultState() {
        setDefaultShareButton()
        setDefaultImagePicker()
        navigationItem.title = "Create a Recipe! :) "
    }
    private func setDefaultImagePicker() {
        recipeImagePickerView.image = nil
    }

    private func setDefaultShareButton() {
        shareButton.isEnabled = false
    }
}
// MARK: - Image Picker Controller Delegate
extension CreateRecipeViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        recipeImagePickerView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Text Field Delegate
extension CreateRecipeViewController: UITextViewDelegate, UITextFieldDelegate {
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        //        if recipeTextView.text == "Please give the recipe details." {
//        //            recipeTextView.text = ""
//        //            shareButton.isEnabled = true
//        //        }
//    }
//    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
//        //  recipeTextView.resignFirstResponder()
//        return false
//    }
}

extension CreateRecipeViewController: CreateRecipeViewModelDelegate{
    func showAlert(message: String) {
        
    }
    
    func recipeToEditArrived(title: String, image: String, instruction: String, ingredients: String) {
        recipeNameField.text = title
        ingredientsTextView.text = ingredients // TODO dynamic ingredients height
        instructionsTextView.text = instruction
        guard let imageUrl:URL = URL(string: image) else {return}
        recipeImagePickerView.loadImage(withUrl: imageUrl)
    }
    
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
//    func editRecipeButtonPressed() {
//        <#code#>
//    }
//    
//    func instructionLoaded(instruction: String) {
//        <#code#>
//    }
//    
//    func ingredientsLoaded(ingredients: [String]) {
//        <#code#>
//    }
    
    
}
