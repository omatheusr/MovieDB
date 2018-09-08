//
//  MovieStorage.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import Foundation

final class MovieStorage: Storage {
    
    typealias DataType = Movie
    
    private(set) var data: [Movie] = []
    private(set) var currentPage: Int = 0
    private(set) var hasReachedEndOfItems: Bool = false
    private(set) var isUpdating: Bool = false
    
    let language: String = "en-US"
    
    func loadData(reset: Bool = false, nextPage: Bool = true, success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        if isUpdating { return }
        
        if !reset {
            if hasReachedEndOfItems {
                success()
                return
            }
            if nextPage {
                currentPage += 1
            }
        } else {
            data = []
            currentPage = 1
        }
        
        isUpdating = true
        MovieDb.requestUpcomingMovies(forPage: currentPage, andLanguage: language, success: { [weak self] (moviesList) in
            guard let `self` = self else { return }
            
            let newMovies = moviesList.movies.filter({ [weak self] (movie) -> Bool in
                guard let `self` = self else { return false }
                return !self.data.contains(movie)
            })
            self.data += newMovies
            
            self.hasReachedEndOfItems = newMovies.count <= 0
            self.isUpdating = false
            success()
        }, failure: { [weak self] (error) in
            guard let `self` = self else { return }
            self.isUpdating = false
            failure(error)
        })
    }
    
}
