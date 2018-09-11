//
//  MoviesListViewModel.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MoviesListViewModel {
    
    // MARK: - Data
    weak var delegate: MoviesListViewModelDelegate?
    
    private weak var movieStorage: MovieStorage!
    private var movieCardViewModels: [MovieCardViewModel?] = []
    
    required init(with movieStorage: MovieStorage) {
        self.movieStorage = movieStorage
    }
    
    // MARK: - Actions
    private func loadIfNeeded(for index: Int, reset: Bool = false) {
        let dispatchSemaphore = DispatchSemaphore(value: 1)
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let `self` = self else { return }
            
            let isLoadingGenres = GenreStorage.shared.loadIfNeeded(completion: {
                dispatchSemaphore.signal()
            })
            if isLoadingGenres {
                dispatchSemaphore.wait()
            }
        
            let page = self.movieStorage.page(for: index)
            self.movieStorage.load(page: page, success: { [weak self] newMovies in
                guard let `self` = self else { return }
                self.setInitialMovieGlanceViewModelsIfNeeded()
                self.updateMovieGlanceViewModelsIfNeeded(with: newMovies)
            }, failure: { [weak self] error in
                guard let `self` = self else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.movieListViewModelDidReceiveError(error)
                }
                
            })
        }
    }
    
    
    private func setInitialMovieGlanceViewModelsIfNeeded() {
        if movieCardViewModels.count == movieStorage.totalResults { return }
        
        let numberOfViewModels = movieStorage.totalResults - movieCardViewModels.count
        if numberOfViewModels <= 0 { return }
        
        movieCardViewModels += [MovieCardViewModel?](repeating: nil, count: numberOfViewModels)
        
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.movieListViewModelDidUpdateData()
        }
        
    }
    private func updateMovieGlanceViewModelsIfNeeded(with movies: [Movie]) {
        for movie in movies {
            guard let index = movieStorage.index(of: movie), let viewModel = movieCardViewModels[index] else { continue }
            viewModel.movie = movie
        }
    }
}

extension MoviesListViewModel: MoviesListViewModelProtocol {
    
    var numberOfSections: Int { return 1 }
    var heightForRow: CGFloat { return 206 }
    
    var numberOfRows: Int {
        return movieStorage.totalResults
    }
    
    func load() {
        loadIfNeeded(for: 0, reset: true)
    }
    
    func getMovieCardViewModel(for indexPath: IndexPath) -> MovieCardViewModel? {
        guard movieCardViewModels.count > indexPath.row else { return nil }
        var viewModel: MovieCardViewModel! = movieCardViewModels[indexPath.row]
        
        if viewModel == nil {
            viewModel = MovieCardViewModel()
            movieCardViewModels[indexPath.row] = viewModel
            
            if let movie = movieStorage.getMovie(at: indexPath.row) {
                viewModel.movie = movie
            }
        }
        return viewModel
    }
    
    func willDisplayCell(at indexPath: IndexPath) {
        loadIfNeeded(for: indexPath.row)
    }
    
}
