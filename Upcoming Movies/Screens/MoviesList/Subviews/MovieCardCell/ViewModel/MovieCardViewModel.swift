//
//  MovieCardViewModel.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MovieCardViewModel {
    
    weak var delegate: MovieCardViewModelDelegate? {
        didSet { updatedMovie() }
    }
    
    weak var movie: Movie? {
        didSet { updatedMovie() }
    }
    
    private func updatedMovie() {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.movieCardViewModelDidUpdateMovie()
        }
    }
}

extension MovieCardViewModel: MovieCardViewModelProtocol { }

extension MovieCardViewModel: MovieFormatter { }

extension MovieCardViewModel: Equatable {
    
    static func == (lhs: MovieCardViewModel, rhs: MovieCardViewModel) -> Bool {
        return lhs.movieId == rhs.movieId
    }
    
}
