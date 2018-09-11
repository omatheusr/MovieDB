//
//  MoviesListCoordinator.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/7/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MoviesListCoordinator {
    
    private(set) var navigationController: UINavigationController
    private(set) var childCoordinator: Coordinator?
    private let movieStorage: MovieStorage
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.movieStorage = MovieStorage()
    }
    
    private func showMoviesList() {
        let moviesListViewModel = MoviesListViewModel(with: movieStorage)
        let moviesListView = MoviesListView(with: moviesListViewModel)
        moviesListView.delegate = self
        
        navigationController.viewControllers = [moviesListView]
    }
    
    private func showMovieDetailsForMovie(at index: Int) {
        guard let movie = movieStorage.getMovie(at: index) else {
            return
        }
        
        let movieDetailsCoordinator = MovieDetailsCoordinator(with: navigationController, andMovie: movie)
        movieDetailsCoordinator.start()
        
        childCoordinator = movieDetailsCoordinator
    }
    
}

extension MoviesListCoordinator: Coordinator {
    
    func start() {
        showMoviesList()
    }
    
}

extension MoviesListCoordinator: MoviesListViewDelegate {
    
    func moviesListViewDidSelectCell(at indexPath: IndexPath) {
        showMovieDetailsForMovie(at: indexPath.row)
    }
    
}
