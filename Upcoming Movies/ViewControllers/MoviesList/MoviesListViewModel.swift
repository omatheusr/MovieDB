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
    private weak var movieStorage: MovieStorage!
    private var movieGlanceViewModels: [MovieGlanceViewModel?] = []
    
    required init(withMovieStorage movieStorage: MovieStorage) {
        self.movieStorage = movieStorage
        super.init()
    }
    
    // MARK: - Properties
    var moviesCount: Int {
        return self.movieGlanceViewModels.count
    }
    
    func getMovieGlanceViewModel(forIndexPath indexPath: IndexPath) -> MovieGlanceViewModel? {
        guard movieGlanceViewModels.count > indexPath.row else { return nil }
        var viewModel: MovieGlanceViewModel! = movieGlanceViewModels[indexPath.row]
        
        if viewModel == nil {
            viewModel = MovieGlanceViewModel()
            movieGlanceViewModels[indexPath.row] = viewModel
            
            if let movie = movieStorage.getMovie(atIndex: indexPath.row) {
                viewModel.movie = movie
            }
        }
        return viewModel
    }
    
    // MARK: - Actions
    func willDisplayCell(atIndexPath indexPath: IndexPath) {
        loadIfNeeded(forIndex: indexPath.row)
    }
    
    func loadIfNeeded(forIndex index: Int, reset: Bool = false) {
        if reset {
            self.movieGlanceViewModels = []
        }
        
        let dispatchSemaphore = DispatchSemaphore(value: 1)
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let `self` = self else { return }
            
            GenreStorage.shared.loadData(reset: reset) {
                dispatchSemaphore.signal()
            }
            dispatchSemaphore.wait()
        
            let page = self.movieStorage.page(forIndex: index)
            self.movieStorage.load(page: page, success: { [weak self] newMovies in
                guard let `self` = self else { return }
                if self.setInitialMovieGlanceViewModelsIfNeeded() {
                    DispatchQueue.main.async {
                        self.didUpdate?()
                    }
                }
                self.updateMovieGlanceViewModelsIfNeeded(withMovies: newMovies)
                
            }, failure: { [weak self] error in
                guard let `self` = self else { return }
                DispatchQueue.main.async {
                    self.didFail?(error)
                }
            })
        }
    }
    
    @discardableResult
    private func setInitialMovieGlanceViewModelsIfNeeded() -> Bool {
        if self.movieGlanceViewModels.count == self.movieStorage.totalResults {
            return false
        }
        let numberOfViewModels = self.movieStorage.totalResults - self.movieGlanceViewModels.count
        if numberOfViewModels <= 0 {
            return false
        }
        self.movieGlanceViewModels += [MovieGlanceViewModel?](repeating: nil, count: numberOfViewModels)
        return true
    }
    private func updateMovieGlanceViewModelsIfNeeded(withMovies movies: [Movie]) {
        for movie in movies {
            guard let index = movieStorage.index(ofMovie: movie), let viewModel = movieGlanceViewModels[index] else { continue }
            viewModel.movie = movie
        }
    }
    
}
