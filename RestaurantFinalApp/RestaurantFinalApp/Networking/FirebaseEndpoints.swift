//
//  FirebaseEndpoints.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 13.08.2021.
//

import Firebase


enum FirebaseEndpoints {
    private static let base = Database.database().reference()

    case myRecipes
    
    var getDatabasePath: DatabaseReference {
        switch self {
        case .myRecipes:
            return FirebaseEndpoints.base.child("users").child("userID").child("myRecipes")
        }
    }
    
}
