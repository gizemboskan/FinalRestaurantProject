//
//  CreateRecipeViewController.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import UIKit
import WSTagsField 
class CreateRecipeViewController: UIViewController, UINavigationControllerDelegate {
    // MARK: - Properties
    let viewModel: CreateRecipeViewModel = CreateRecipeViewModel()
    
    
    // MARK: - UI ComponentsUT
    @IBOutlet weak var recipeImagePickerView: UIImageView!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var imagePickerButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var recipeNameField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tagsField: WSTagsField!
    
    @IBOutlet weak var editRecipeButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var viewWithButton: UIView!
    
    @IBOutlet weak var viewWithButton2: UIView!
    @IBOutlet weak var createRecipeView: UIView!
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        viewModel.delegate = self
        instructionsTextView.delegate = self
        recipeNameField.delegate = self
        viewModel.editArrivedRecipe()
        
        setTagsFieldProperties()
        createRecipeView.roundCorners([.topLeft, .topRight], radius: 40)
        viewWithButton.roundCorners(.allCorners, radius: 60)
        viewWithButton2.roundCorners(.allCorners, radius: 40)
        imagePickerButton.roundCorners(.allCorners, radius: 20)
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
        viewModel.shareRecipe(sender)
    }
    @IBAction func imagePickerButtonTapped(_ sender: UIButton) {
        viewModel.pickAnImage(sender)
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
        viewModel.doneEditing(title: recipeNameField.text ?? "", image: recipeImagePickerView.image?.pngData() ?? Data(), instruction: instructionsTextView.text, ingredients: tagsField.tags.map({ $0.text }))
    }
    private func pickImage(sourceType: UIImagePickerController.SourceType) {
        viewModel.selectImagePickerSource(sourceType: sourceType)
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
        navigationItem.title = "Create or Edit a Recipe! :) "
    }
    private func setDefaultImagePicker() {
        recipeImagePickerView.image = nil
    }
    
    private func setDefaultShareButton() {
        shareButton.isEnabled = false
    }
    private func setTagsFieldProperties(){
        tagsField.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        tagsField.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tagsField.spaceBetweenLines = 5.0
        tagsField.spaceBetweenTags = 10.0
        tagsField.font = .systemFont(ofSize: 12.0)
        tagsField.backgroundColor = .white
        tagsField.tintColor = .systemOrange
        tagsField.textColor = .systemGray4
        tagsField.textField.textColor = .blue
        tagsField.selectedColor = .black
        tagsField.selectedTextColor = .red
        tagsField.delimiter = "--"
        tagsField.isDelimiterVisible = false
        tagsField.placeholder = "ingredient"
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



// MARK: - CreateRecipeViewModelDelegate

extension CreateRecipeViewController: CreateRecipeViewModelDelegate{
    func showLoadingIndicator(isShown: Bool) {
        if isShown {
            startLoading()
        } else {
            stopLoading()
        }
    }
    
    func imagePickerSource(sourceType: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType as! UIImagePickerController.SourceType
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerButtonPressed(_ sender: Any) {
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
    
    func showAlert(message: String, title: String) {
        showAlertController(message: message, title: title)
    }
    
    func recipeToEditArrived(title: String, image: String, instruction: String, ingredients: [String]) {
        recipeNameField.text = title
        tagsField.addTags(ingredients)
        instructionsTextView.text = instruction
        guard let imageUrl:URL = URL(string: image) else {return}
        recipeImagePickerView.loadImage(withUrl: imageUrl)
    }
    
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}
