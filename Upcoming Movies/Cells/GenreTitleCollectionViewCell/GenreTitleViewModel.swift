//
//  GenreTitleViewModel.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import Foundation

final class GenreTitleViewModel: ViewModel {
    
    // MARK: - Data
    private(set) weak var genre: Genre!
    
    init(withGenre genre: Genre) {
        self.genre = genre
    }
    
    // MARK: - Properties
    var genreTitle: String {
        return genre.name.uppercased()
    }
    
}
