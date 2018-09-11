//
//  MovieDetailsViewModelProtocol.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import Foundation

protocol MovieDetailsViewModelProtocol: class {
    
    var delegate: MovieDetailsViewModelDelegate? { get set }
    
}
