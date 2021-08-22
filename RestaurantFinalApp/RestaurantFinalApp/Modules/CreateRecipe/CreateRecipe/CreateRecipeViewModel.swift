//
//  CreateRecipeViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import Foundation
import Firebase

protocol CreateRecipeViewModelDelegate: AnyObject {
    func showAlert(message: String, title: String)
    func showLoadingIndicator(isShown: Bool)
    func recipeToEditArrived(title: String, image: String, instruction: String, ingredients: [String])
    func backButtonPressed()
    func shareButtonPressed()
    func imagePickerButtonPressed()
    func imagePickerSource()
    func doneButtonPressed()
    func isBackButtonHidden(isHidden: Bool)
}

protocol CreateRecipeViewModelProtocol {
    var delegate: CreateRecipeViewModelDelegate? { get set }
    var recipeToEdit: RecipeModel? { get set }
    func setRecipeStatus()
    func shareRecipe()
    func pickAnImage()
    func saveRecipe(title: String, image: Data, instruction: String, ingredients: [String])
    func selectImagePickerSource()
    func quitView()
    func doneEditing(title: String, image: Data, instruction: String, ingredients: [String])
    func cancelEditing()
}


final class CreateRecipeViewModel {
    
    weak var delegate: CreateRecipeViewModelDelegate?
    
    var recipeToEdit: RecipeModel?
}

extension CreateRecipeViewModel: CreateRecipeViewModelProtocol {

    func setRecipeStatus() {
        delegate?.isBackButtonHidden(isHidden: recipeToEdit == nil)
        delegate?.recipeToEditArrived(title: (recipeToEdit?.name ?? ""), image: (recipeToEdit?.imageURL ?? ""), instruction: (recipeToEdit?.instruction ?? ""), ingredients: (recipeToEdit?.ingredients ?? []))
    }
    
    func doneEditing(title: String, image: Data, instruction: String, ingredients: [String]) {
        delegate?.showLoadingIndicator(isShown: true)
        
        var imagePath = UUID().uuidString
        imagePath.removeAll(where: { $0 == "-"})
        // Create a reference to the file you want to upload
        let imageRef = FirebaseEndpoints.baseStorage.child("images/\(imagePath).png")
        

        imageRef.putData(image, metadata: nil) { (metadata, error) in

            guard metadata != nil else {
                self.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
                self.delegate?.showLoadingIndicator(isShown: false)
                return
            }
            
            // You can also access to download URL after upload.
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    self.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
                    self.delegate?.showLoadingIndicator(isShown: false)
                    return
                }
                
                let imageURL = downloadURL.absoluteString
                
                // my user trys to edit selected recipe
                if self.recipeToEdit != nil {
                    self.recipeToEdit?.name = title
                    self.recipeToEdit?.imageURL = imageURL
                    self.recipeToEdit?.instruction = instruction
                    self.recipeToEdit?.ingredients = ingredients
                    
                    if let recipeToEdit = self.recipeToEdit {
                        
                        FirebaseEndpoints.myUser.getDatabasePath.child("recipes").child(recipeToEdit.id).updateChildValues(recipeToEdit.dictionary) { error, reference in
                            self.delegate?.showLoadingIndicator(isShown: false)
                            if let error = error {
                                print("Data could not be saved: \(error).")
                                self.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
                            } else {
                                print("Data saved successfully!")
                                self.delegate?.showAlert(message: "general_success_desc".localized(), title: "")
                            }
                        }
                    }
                } else {
                    let newRecipe = RecipeModel(id: UUID().uuidString, name: title, imageURL: imageURL, instruction: instruction, ingredients: ingredients)
                    FirebaseEndpoints.myUser.getDatabasePath.child("recipes").child(newRecipe.id).setValue(newRecipe.dictionary) { [weak self]
                        (error:Error?, reference) in
                        self?.delegate?.showLoadingIndicator(isShown: false)

                        if let error = error {
                            self?.delegate?.showAlert(message: "error", title: "Error")
                            print("Data could not be saved: \(error).")
                            self?.delegate?.showAlert(message: "general_error_desc".localized(), title: "general_error_title".localized())
                        } else {
                            self?.delegate?.showAlert(message: "general_success_desc".localized(), title: "")
                            self?.cancelEditing()
                        }
                    }
                }
                
            }
        }
    }
    
    func cancelEditing() {
        delegate?.recipeToEditArrived(title: "", image: "", instruction: "", ingredients: [])
    }
    
    func shareRecipe() {
        delegate?.shareButtonPressed()
    }
    
    func saveRecipe(title: String, image: Data, instruction: String, ingredients: [String]) {
        if title.isEmpty || image.isEmpty || instruction.isEmpty || ingredients.isEmpty {
            delegate?.showAlert(message: "Please fill all the fields!",
                                title: "Warning")
            return
        }
        
        delegate?.doneButtonPressed()
    }
    
    func pickAnImage() {
        delegate?.imagePickerButtonPressed()
    }
    
    func quitView() {
        delegate?.backButtonPressed()
    }
    
    func selectImagePickerSource() {
        delegate?.imagePickerSource()
    }
}
