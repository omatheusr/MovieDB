//
//  Requester.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/7/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import Foundation

enum RequestResponse {
    case success(data: Data, error: Error?, response: HTTPURLResponse?)
    case fail(data: Data?, error: Error?, response: HTTPURLResponse?)
}

final class Requester {
    
    enum HttpMethod: String {
        case post, get, delete, put
    }
    
    static let shared: Requester = Requester(withURLSession: URLSession.shared)
    
    private let urlSession: URLSession
    
    init(withURLSession urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func execute(requestForURL url: URL, usingHttpMethod method: Requester.HttpMethod, sendingData data: Data? = nil, withHeaders headers: [String: String] = [:], completion: @escaping (RequestResponse) -> Void) {
        var request = URLRequest(url: url)
        
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        request.httpMethod = method.rawValue.uppercased()
        request.httpBody = data
        
        self.urlSession.dataTask(with: request) { data, resp, error in
            if let data = data {
                completion(RequestResponse.success(data: data, error: error, response: resp as? HTTPURLResponse))
            } else {
                completion(RequestResponse.fail(data: data, error: error, response: resp as? HTTPURLResponse))
            }
        }.resume()
    }
    
}
