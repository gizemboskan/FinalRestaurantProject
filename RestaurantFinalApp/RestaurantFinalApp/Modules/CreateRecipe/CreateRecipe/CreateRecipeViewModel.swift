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
    func shareButtonPressed(_ sender: Any)
    func imagePickerButtonPressed(_ sender: Any)
    func imagePickerSource(sourceType: Any)
}

class CreateRecipeViewModel {
    
    weak var delegate: CreateRecipeViewModelDelegate?
    
    var recipeToEdit: RecipeModel?
    
    func editArrivedRecipe() {
        delegate?.recipeToEditArrived(title: (recipeToEdit?.name ?? ""), image: (recipeToEdit?.imageURL ?? ""), instruction: (recipeToEdit?.instruction ?? ""), ingredients: (recipeToEdit?.ingredients ?? []))
    }
    
    func doneEditing(title: String, image: Data, instruction: String, ingredients: [String]) {
        delegate?.showLoadingIndicator(isShown: true)
        
        if title.isEmpty || image.isEmpty || instruction.isEmpty || ingredients.isEmpty {
            delegate?.showAlert(message: "Please fill all the fields!", title: "Warning")
            delegate?.showLoadingIndicator(isShown: false)
            return
        }
        
        var imagePath = UUID().uuidString
        imagePath.removeAll(where: { $0 == "-"})
        // Create a reference to the file you want to upload
        let imageRef = FirebaseEndpoints.baseStorage.child("images/\(imagePath).png")
        

        imageRef.putData(image, metadata: nil) { (metadata, error) in

            guard metadata != nil else {
                // TODO alert error
                // Uh-oh, an error occurred!
                self.delegate?.showLoadingIndicator(isShown: false)
                return
            }
            
            // You can also access to download URL after upload.
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
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
                                // TODO show alert
                            } else {
                                print("Data saved successfully!")
                                // TODO show success alert
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
                            // TODO show alert
                        } else {
                            print("Data saved successfully!")
                            // TODO show success alert
                        }
                    }
                }
                
            }
        }
    }
    
    func shareRecipe(_ sender: Any){
        delegate?.shareButtonPressed(sender)
        
    }
    func pickAnImage(_ sender: Any){
        delegate?.imagePickerButtonPressed(sender)
    }
    func quitView(){
        delegate?.backButtonPressed()
    }
    func selectImagePickerSource(sourceType: Any){
        delegate?.imagePickerSource(sourceType: sourceType)
    }
}
