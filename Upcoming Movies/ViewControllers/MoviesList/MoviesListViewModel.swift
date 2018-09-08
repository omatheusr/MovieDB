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
    private let movieStorage: MovieStorage
    
    required init(withMovieStorage movieStorage: MovieStorage) {
        self.movieStorage = movieStorage
    }
    
    // MARK: - Properties
    var shouldShowLoadingCell: Bool {
        return !movieStorage.hasReachedEndOfItems
    }
    var moviesCount: Int {
        return movieStorage.count + 1
    }
    
    func getMovieGlanceViewModel(forIndexPath indexPath: IndexPath) -> MovieGlanceViewModel? {
        if indexPath.row >= movieStorage.count {
            return nil
        }
        return MovieGlanceViewModel(withMovie: movieStorage.data[indexPath.row])
    }
    
    // MARK: - Actions
    func update(reset: Bool = false, nextPage: Bool = true) {
        if (!reset && movieStorage.hasReachedEndOfItems) || isUpdating {
            return
        }
        
        self.isUpdating = true
        
        GenreStorage.shared.loadData(reset: reset) { [weak self] in
            guard let `self` = self else { return }
            
            self.movieStorage.loadData(reset: reset, nextPage: nextPage, success: { [weak self] in
                guard let `self` = self else { return }
                self.isUpdating = false
            }, failure: { [weak self] (error) in
                guard let `self` = self else { return }
                self.isUpdating = false
                self.didFail?(error)
            })
            
        }
        
        
        
        
    }
    
}
