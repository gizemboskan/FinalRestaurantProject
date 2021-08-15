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
    var location: String
    var recipes: [RecipeModel]
    var description: String
    var avarageDeliveryTime: String
    
    // TO DO: fav count ve puan eklenebilir..
    
    var dictionary: [String: Any] {
        return ["id": id,
                "name": name,
                "imageURL": imageURL,
                "location": location,
                "recipes": recipes,
                "description": description,
                "avarageDeliveryTime": avarageDeliveryTime
        ]
    }
    
    static func getKitchenFromDict(kitchenDetails: [String: Any]) -> KitchenModel {
        return KitchenModel(id: kitchenDetails["id"] as! String,
                            name: kitchenDetails["name"] as! String,
                            imageURL: kitchenDetails["imageURL"] as! String,
                            location: kitchenDetails["location"] as! String,
                            recipes: kitchenDetails["recipes"] as! [RecipeModel],
                            description: kitchenDetails["description"] as! String,
                            avarageDeliveryTime: kitchenDetails["avarageDeliveryTime"] as! String)
    }
}
