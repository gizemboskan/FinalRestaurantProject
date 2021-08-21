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
            return FirebaseEndpoints.base.child("users").child("03DA8FF3-B6D8-4261-9C29-4D9A13FCC1D1")
        case .kitchens:
            return FirebaseEndpoints.base.child("kitchens")
        case .recipes:
            return FirebaseEndpoints.base.child("recipes")
        }
    }
}
