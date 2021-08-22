//
//  FirebaseEndpoints.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 13.08.2021.
//

import Firebase

enum FirebaseEndpoints {
    private static let base = Database.database().reference()
    static let baseStorage = Storage.storage().reference()

    case kitchens
    case users
    case recipes
    case myUser
    
    var getDatabasePath: DatabaseReference {
        switch self {
        case .users:
            return FirebaseEndpoints.base.child("users")
        case .myUser:
            return FirebaseEndpoints.base.child("users").child("50D8CD3F-51DD-4D11-A8E9-254C97E66A5A")
        case .kitchens:
            return FirebaseEndpoints.base.child("kitchens")
        case .recipes:
            return FirebaseEndpoints.base.child("recipes")
        }
    }
}
