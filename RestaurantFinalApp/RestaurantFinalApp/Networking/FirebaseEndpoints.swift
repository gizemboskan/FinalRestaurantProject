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
            return FirebaseEndpoints.base.child("users").child("560ABA62-0558-4278-AAF7-0BCB18772C88")
        case .kitchens:
            return FirebaseEndpoints.base.child("kitchens")
        case .recipes:
            return FirebaseEndpoints.base.child("recipes")
        }
    }
}
