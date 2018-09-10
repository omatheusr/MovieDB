//
//  MoviesListCoordinator.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/7/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MoviesListCoordinator: Coordinator {
    
    private(set) var navigationController: UINavigationController
    private(set) var childCoordinator: Coordinator?
    private let movieStorage: MovieStorage
    
    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.movieStorage = MovieStorage()
    }
    
    func start() {
        let moviesListViewModel = MoviesListViewModel(withMovieStorage: movieStorage)
        let moviesListViewController = MoviesListViewController(withViewModel: moviesListViewModel)
        moviesListViewController.delegate = self
        
        navigationController.viewControllers = [moviesListViewController]
    }
    
    func showMovieDetailsForMovie(atIndex index: Int) {
        guard let movie = movieStorage.getMovie(atIndex: index) else {
            return
        }
        
        let movieDetailsCoordinator = MovieDetailsCoordinator(withNavigationController: navigationController, andMovie: movie)
        movieDetailsCoordinator.start()
        
        childCoordinator = movieDetailsCoordinator
    }
    
}

extension MoviesListCoordinator: MoviesListViewControllerDelegate {
    
    func moviesListViewControllerDidSelectCell(atIndexPath indexPath: IndexPath) {
        showMovieDetailsForMovie(atIndex: indexPath.row)
    }
    
}
