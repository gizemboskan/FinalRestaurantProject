//
//  CreateRecipeViewModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 8.08.2021.
//

import Foundation
import Firebase

protocol CreateRecipeViewModelDelegate: AnyObject {
    func showAlert(message: String)
    func recipeToEditArrived(title: String, image: String, instruction: String, ingredients: String)
    func backButtonPressed()
    
    //    func editProcessCompleted(endingEditingStateImage: String)
    //    func editRecipeButtonPressed()
    //    func instructionLoaded(instruction: String)
    //    func ingredientsLoaded(ingredients: [String])
    
    func shareButtonPressed(_ sender: Any)
    func imagePickerButtonPressed(_ sender: Any)
    func imagePickerSource(sourceType: Any)
}

class CreateRecipeViewModel {
    
    weak var delegate: CreateRecipeViewModelDelegate?
    
    var recipeToEdit: RecipeModel?
    
    func editArrivedRecipe() {
        delegate?.recipeToEditArrived(title: (recipeToEdit?.name ?? ""), image: (recipeToEdit?.imageURL ?? ""), instruction: (recipeToEdit?.instruction ?? "Write down your instructions!"), ingredients: (recipeToEdit?.ingredients.joined(separator: " ") ?? "Write down your ingredients!"))
    }
    
    func doneEditing(title: String, image: Data, instruction: String, ingredients: String) {
        var imagePath = UUID().uuidString
        imagePath.removeAll(where: { $0 == "-"})
        // Create a reference to the file you want to upload
        let imageRef = FirebaseEndpoints.baseStorage.child("images/\(imagePath).png")
        
        // Upload the file to the path "images/rivers.jpg"
        imageRef.putData(image, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            
            // You can also access to download URL after upload.
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                
                let imageURL = downloadURL.absoluteString
                
                // my user trys to edit selected recipe
                if self.recipeToEdit != nil {
                    self.recipeToEdit?.name = title
                    self.recipeToEdit?.imageURL = imageURL
                    self.recipeToEdit?.instruction = instruction
                    self.recipeToEdit?.ingredients = ["todo ingredients"] // TODO remove textview and collectionview and add tags
                    
                    if let recipeToEdit = self.recipeToEdit {
                        
                        FirebaseEndpoints.myUser.getDatabasePath.child("recipes").child(recipeToEdit.id).updateChildValues(recipeToEdit.dictionary) { error, reference in
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
                    let newRecipe = RecipeModel(id: UUID().uuidString, name: title, imageURL: imageURL, instruction: instruction, ingredients: ["TODO"])
                    FirebaseEndpoints.myUser.getDatabasePath.child("recipes").child(newRecipe.id).setValue(newRecipe.dictionary) { [weak self]
                        (error:Error?, reference) in
                        if let error = error {
                            self?.delegate?.showAlert(message: "error")
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
