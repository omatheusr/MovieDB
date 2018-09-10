//
//  MovieStorage.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import Foundation

final class MovieStorage {
    
    typealias DataType = Movie
    
    private(set) var movies: [Movie?] = []
    
    private(set) var totalResults: Int = 0
    private(set) var totalPages: Int = 0
    
    private let pageSize: Int = 20
    private var pagesLoaded: Set<Int> = []
    
    let language: String = "en-US"
    
    private func add(movies newMovies: [Movie], forPage page: Int) {
        if totalResults <= 0 { return }
        if movies.isEmpty {
            movies = [Movie?](repeating: nil, count: totalResults)
        }
        
        let baseIndex: Int = (page - 1) * pageSize
        for newMovie in newMovies.enumerated() {
            movies[baseIndex+newMovie.offset] = newMovie.element
        }
    }
    
    func load(page: Int, success: @escaping ([Movie]) -> Void, failure: @escaping (Error) -> Void) {
        
        let result = pagesLoaded.insert(page)
        if !result.inserted {
            success([])
            return
        }
        
        MovieDb.requestUpcomingMovies(forPage: page, andLanguage: language, success: { [weak self] (moviesList) in
            guard let `self` = self else { return }
            
            self.totalResults = moviesList.totalResults
            self.totalPages = moviesList.totalPages
            
            self.add(movies: moviesList.movies, forPage: page)
            
            success(moviesList.movies)
        }, failure: { [weak self] (error) in
            guard let `self` = self else { return }
            self.pagesLoaded.remove(page)
            failure(error)
        })
    }
    func page(forIndex index: Int) -> Int {
        if index == 0 { return 1 }
        let x = Double(index) / Double(pageSize)
        return Int(ceil(x))
    }
    func index(ofMovie movie: Movie) -> Int? {
        return self.movies.index(of: movie)
    }
    func getMovie(atIndex index: Int) -> Movie? {
        if index >= movies.count {
            return nil
        }
        return movies[index]
    }
}
