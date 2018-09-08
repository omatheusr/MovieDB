//
//  MoviesListViewModel.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import Foundation

final class MoviesListViewModel: ViewModel {
    
    // MARK: - Data
    private var movies: [Movie] = []
    
    // MARK: - Status Machine
    var isUpdating: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.didUpdate?()
            }
        }
    }
    
    // MARK: - Properties
    var moviesCount: Int {
        return movies.count
    }
    
    func getMovieGlanceViewModel(forIndexPath indexPath: IndexPath) -> MovieGlanceViewModel {
        return MovieGlanceViewModel(withMovie: movies[indexPath.row])
    }
    
    // MARK: - Actions
    func updateData() {
        isUpdating = true
        
        MovieDb.requestUpcomingMovies(forPage: 1, andLanguage: "en-US", success: { [weak self] (moviesList) in
            guard let `self` = self else { return }
            
            let newMovies = moviesList.movies.filter({ [weak self] (movie) -> Bool in
                guard let `self` = self else { return false }
                return !self.movies.contains(movie)
            })
            self.movies += newMovies
            self.isUpdating = false
            
        }, failure: { [weak self] (error) in
            guard let `self` = self else { return }
            self.isUpdating = false
            self.didFail?(error)
        })
    }
    
}
