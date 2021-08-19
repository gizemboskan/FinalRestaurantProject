//
//  KitchenModel.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 16.08.2021.
//

import Foundation

struct KitchenModel {
    var id: String
    var name: String
    var imageURL: String
    var locationString: String
    var recipes: [String: Any]
    var descriptions: [String]
    var avarageDeliveryTime: String
    var rating: Double
    var ratingCount: Int
    var latitude: Double
    var longitude: Double
    
    var dictionary: [String: Any] {
        return ["id": id,
                "name": name,
                "imageURL": imageURL,
                "locationString": locationString,
                "recipes": recipes,
                "descriptions": descriptions,
                "avarageDeliveryTime": avarageDeliveryTime,
                "rating": rating,
                "ratingCount": ratingCount,
                "latitude": latitude,
                "longitude": longitude
        ]
    }
    
    static func getKitchenFromDict(kitchenDetails: [String: Any]) -> KitchenModel {
        return KitchenModel(id: kitchenDetails["id"] as! String,
                            name: kitchenDetails["name"] as! String,
                            imageURL: kitchenDetails["imageURL"] as! String,
                            locationString: kitchenDetails["locationString"] as! String,
                            recipes: kitchenDetails["recipes"] as! [String: Any] ,
                            descriptions: kitchenDetails["descriptions"] as! [String],
                            avarageDeliveryTime: kitchenDetails["avarageDeliveryTime"] as! String,
                            rating: kitchenDetails["rating"] as! Double,
                            ratingCount: kitchenDetails["ratingCount"] as! Int,
                            latitude: kitchenDetails["latitude"] as! Double,
                            longitude: kitchenDetails["longitude"] as! Double)
    }
}
