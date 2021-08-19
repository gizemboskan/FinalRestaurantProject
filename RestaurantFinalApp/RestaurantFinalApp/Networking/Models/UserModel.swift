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
    var locationString: String
    var latitude: Double
    var longitude: Double
    
    var dictionary: [String: Any] {
        return ["id": id,
                "name": name,
                "recipes": recipes,
                "locationString": locationString,
                "latitude": latitude,
                "longitude": longitude
        ]
    }
    
    static func getUserFromDict(userDetails: [String: Any]) -> UserModel {
        return UserModel(id: userDetails["id"] as! String,
                         name: userDetails["name"] as! String,
                         recipes: userDetails["recipes"] as! [String: Any],
                         locationString: userDetails["locationString"] as! String,
                         latitude: userDetails["latitude"] as! Double,
                         longitude: userDetails["longitude"] as! Double)
    }
}
