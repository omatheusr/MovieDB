//
//  ImageRequester.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

class ImageRequester {
    
    private static var imageRequesterURLSession: URLSession {
        let session = URLSession(configuration: .default)
        session.configuration.requestCachePolicy = .returnCacheDataElseLoad
        return session
    }
    
    private static let imageRequester: Requester = Requester(withURLSession: ImageRequester.imageRequesterURLSession)
    
    static func requestImage(forURL url: URL, completion: @escaping (UIImage?) -> Void) {
        imageRequester.execute(requestForURL: url, usingHttpMethod: .get) { (response) in
            switch response {
            case .success(let data, _, _):
                completion(UIImage(data: data))
            default:
                completion(nil)
            }
        }
    }
    
}
