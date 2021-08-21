//
//  UserModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 16.08.2021.
//

import Foundation

struct UserModel {
    var id: String
    var name: String
    var recipes: [String: Any]
    
    
    var dictionary: [String: Any] {
        return ["id": id,
                "name": name,
                "recipes": recipes,
                
        ]
    }
    
    static func getUserFromDict(userDetails: [String: Any]) -> UserModel {
        return UserModel(id: userDetails["id"] as! String,
                         name: userDetails["name"] as! String,
                         recipes: userDetails["recipes"] as! [String: Any])
    }
}
