//
//  Genre.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import Foundation

final class Genre: Decodable {
    
    let id: Int
    let name: String
    
}

extension Genre: Equatable {
    
    static func == (lhs: Genre, rhs: Genre) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func == (lhs: Genre, rhs: Int) -> Bool {
        return lhs.id == rhs
    }
    
}
