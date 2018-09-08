//
//  Storage.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import Foundation

protocol Storage {
    
    associatedtype DataType
    
    var data: [DataType] { get }
    var count: Int { get }
    var isUpdating: Bool { get }
    
}

extension Storage {
    
    var count: Int {
        return data.count
    }
    
}
