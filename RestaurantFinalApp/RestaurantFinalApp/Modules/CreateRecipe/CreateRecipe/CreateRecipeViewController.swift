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
    var viewModel: CreateRecipeViewModelProtocol = CreateRecipeViewModel()
    
    // MARK: - UI Components
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
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var viewWithButton: UIView!
    @IBOutlet weak var createRecipeView: UIView!
    @IBOutlet weak var trashButton: UIButton!
    
    private var selectedSourceType: UIImagePickerController.SourceType?
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        viewModel.delegate = self
        instructionsTextView.delegate = self
        recipeNameField.delegate = self
        viewModel.setRecipeStatus()
        setTagsFieldProperties()
        createRecipeView.roundCorners([.topLeft, .topRight], radius: 40)
        viewWithButton.roundCorners(.allCorners, radius: 30)
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
    
    @IBAction func trashTapped(_ sender: UIButton) {
        viewModel.cancelEditing()
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        viewModel.shareRecipe()
    }
    
    @IBAction func imagePickerButtonTapped(_ sender: UIButton) {
        viewModel.pickAnImage()
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
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.viewModel.quitView()
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        viewModel.saveRecipe(title: self.recipeNameField.text ?? "",
                             image: self.recipeImagePickerView.image?.pngData() ?? Data(),
                             instruction: self.instructionsTextView.text,
                             ingredients: self.tagsField.tags.map({ $0.text }))
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
        tagsField.font = .systemFont(ofSize: 14.0)
        tagsField.backgroundColor = .white
        tagsField.tintColor = .systemOrange
        tagsField.textColor = .black
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

}

// MARK: - CreateRecipeViewModelDelegate

extension CreateRecipeViewController: CreateRecipeViewModelDelegate{
    func isBackButtonHidden(isHidden: Bool) {
        backButton.isHidden = isHidden
    }
    
    func doneButtonPressed() {
        let vc = UIAlertController(title: "Save Recipe!", message: "Do you want to save these changes into your page?", preferredStyle: .alert)
        
        
        vc.addAction(UIAlertAction(title: "Save!", style: .default, handler: { UIAlertAction in
                                    
                                    self.viewModel.doneEditing(title: self.recipeNameField.text ?? "", image: self.recipeImagePickerView.image?.pngData() ?? Data(), instruction: self.instructionsTextView.text, ingredients: self.tagsField.tags.map({ $0.text }))        }))
        vc.addAction(UIAlertAction(title: "Continue editing.", style: .cancel))
        present(vc, animated: true)
    }
    
    func showLoadingIndicator(isShown: Bool) {
        if isShown {
            startLoading()
        } else {
            stopLoading()
        }
    }
    
    func imagePickerSource() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = selectedSourceType ?? .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerButtonPressed() {
        let vc = UIAlertController(title: "Picure Selection", message: "Please pick a picture for your meal!", preferredStyle: .actionSheet)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
        }
        vc.addAction(cancelButton)
        let cameraButton = UIAlertAction(title: "Use Camera", style: .default) { UIAlertAction in
            self.selectedSourceType = .camera
            self.viewModel.selectImagePickerSource()
        }
        vc.addAction(cameraButton)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        let albumButton = UIAlertAction(title: "Use Photo Library", style: .default) { UIAlertAction in
            self.selectedSourceType = .photoLibrary
            self.viewModel.selectImagePickerSource()
        }
        vc.addAction(albumButton)
        present(vc, animated: true)
    }
    
    func shareButtonPressed() {
        let vc = UIActivityViewController(activityItems: ["Share this great recipe with your loved ones! :)\n Or just save!"] , applicationActivities: [])
        vc.popoverPresentationController?.sourceView = view
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
        instruction.isEmpty ? tagsField.removeTags() : tagsField.addTags(ingredients)
        instructionsTextView.text = instruction
        guard let imageUrl:URL = URL(string: image) else {
            recipeImagePickerView.image = UIImage(named: "noImagePlaceholder")
            return
        }
        recipeImagePickerView.loadImage(withUrl: imageUrl)
    }
    
    func backButtonPressed() {
        let vc = UIAlertController(title: "Quit", message: "Do you want to leave this without saving your changes?", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Quit, anyway!", style: .destructive, handler: { UIAlertAction in
            
            self.navigationController?.popViewController(animated: true)
        }))
        vc.addAction(UIAlertAction(title: "Oh, no! Stay.", style: .cancel))
        present(vc, animated: true)
        
    }
}
