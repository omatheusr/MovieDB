//
//  MovieGlanceViewModel.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MovieGlanceViewModel: ViewModel {
    
    // MARK: - Data
    private var movie: Movie!
    
    
    init(withMovie movie: Movie) {
        self.movie = movie
    }
    
    // MARK: - Status Machine
    var isUpdating: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.didUpdate?()
            }
        }
    }
    
    // MARK: - Properties
    private(set) var posterImage: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.didUpdate?()
            }
        }
    }
    
    var movieTitle: String {
        return movie?.title ?? "-"
    }
    var movieReleaseDate: String {
        return movie?.releaseDate ?? "-"
    }
    
    // MARK: - Actions
    func update() {
        self.isUpdating = true
        self.isUpdating = false
        
        if let posterPath = movie.backdropPath {
            ImageRequester.requestImage(forURL: MovieDbAPI.getImageUrl(forImagePath: posterPath)) { [weak self] (image) in
                guard let `self` = self else { return }
                self.posterImage = image
            }
        }
    }
    
}
