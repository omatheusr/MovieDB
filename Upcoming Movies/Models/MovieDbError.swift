//
//  MovieDbError.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/7/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import Foundation

final class MovieDbError: Decodable {
    let code: Int
    let message: String
    
    init(error: Error?) {
        self.code = -1
        self.message = error?.localizedDescription ?? "An error ocurred"
    }
    
    private enum CodingKeys: String, CodingKey {
        case code = "statusCode"
        case message = "statusMessage"
    }
}
