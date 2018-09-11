//
//  MovieDbImage.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MovieDbImage {
    enum ImageSize: String {
        case original = "original"
        case small = "w500"
    }
    
    private static var cache = NSCache<NSString, UIImage>()
    
    @discardableResult
    static func request(forPath path: String, withSize size: ImageSize = ImageSize.small, completion: @escaping (UIImage?) -> Void) -> Bool {
        
        let imagePath = "\(size.rawValue)\(path)"
        
        if let image = MovieDbImage.cache.object(forKey: imagePath as NSString) {
            completion(image)
            return false
        }
        
        MovieDb.requestImage(forPath: imagePath) { (imageData) in
            if let data = imageData, let image = UIImage(data: data) {
                MovieDbImage.cache.setObject(image, forKey: imagePath as NSString)
                completion(image)
            } else {
                completion(nil)
            }
        }
        
        return true
    }
    
}
