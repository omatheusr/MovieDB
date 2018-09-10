//
//  MovieDetailsViewModel.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MovieDetailsViewModel: MovieViewModel {
    
    required convenience init(withMovie movie: Movie) {
        self.init()
        self.movie = movie
    }
    
}
