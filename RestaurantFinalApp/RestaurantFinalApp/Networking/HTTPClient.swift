//
//  HTTPClient.swift
//  RestaurantFinalApp
//
//  Created by Gizem Boskan on 13.08.2021.
//

import UIKit
import CoreData

class HTTPClient {
    class func downloadImage(path: String, completion: @escaping (Data?, Error?) -> Void) {
        if let image = HTTPClient.isImageOnCache(by: path) {
            DispatchQueue.main.async {
                completion(image, nil)
            }
        } else {
            HTTPClient.getImageOnline(by: path) { data, error in
                if error != nil {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                } else {
                    if let data = data {
                        DispatchQueue.main.async {
                            saveImageToCache(id: path, imageData: data)
                            completion(data, nil)
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(nil, nil)
                        }
                    }
                }
            }
        }
    }
    
    private class func saveImageToCache(id: String, imageData: Data) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let newImage = NSEntityDescription.insertNewObject(forEntityName: "Image", into: context)
        newImage.setValue(id, forKey: "id")
        newImage.setValue(imageData, forKey: "imageData")
        do {
            try context.save()
        } catch  {
            print("Could not be saved!")
        }
    }
    
    private class func isImageOnCache(by id: String) -> Data? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil}
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                if let results = results as? [NSManagedObject] {
                    if let imageObject = results.first(where: {($0.value(forKey: "id") as? String) == id }) {
                        if let imageData = imageObject.value(forKey: "imageData") as? Data{
                            return imageData
                        }
                    }
                }
            }
            return nil
        } catch {
            return nil
        }
    }
    
    private class func getImageOnline(by urlString: String, completion: @escaping (Data?, Error?) -> Void ) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                completion(data, error)
            }
            task.resume()
        }
    }
}
