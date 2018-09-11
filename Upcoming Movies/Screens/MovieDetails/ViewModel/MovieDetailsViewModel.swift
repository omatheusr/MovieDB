//
//  MovieDetailsViewModel.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MovieDetailsViewModel {
    
    weak var movie: Movie? {
        didSet { update() }
    }
    
    weak var delegate: MovieDetailsViewModelDelegate? {
        didSet { update() }
    }
    
    init(with movie: Movie?) {
        self.movie = movie
    }
    
    private func update() {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.movieDetailDidUpdate()
        }
    }
    
}

extension MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
}
extension MovieDetailsViewModel: MovieFormatter {
    
}
