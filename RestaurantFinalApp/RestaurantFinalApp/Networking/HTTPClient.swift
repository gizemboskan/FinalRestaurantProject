//
//  HTTPClient.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 13.08.2021.
//

import Foundation

class HTTPClient {
    class func downloadImage(path: String, completion: @escaping (Data?, Error?) -> Void) {
        if let url = URL(string: path) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    completion(data, error)
                }
            }
            task.resume()
        }
    }
}
