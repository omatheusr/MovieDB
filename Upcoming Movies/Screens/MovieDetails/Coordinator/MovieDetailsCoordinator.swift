//
//  MovieDetailsCoordinator.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MovieDetailsCoordinator {
    
    private(set) var topNavigationController: UINavigationController
    private(set) var navigationController: UINavigationController
    private(set) var childCoordinator: Coordinator?
    
    private let movie: Movie
    
    init(with navigationController: UINavigationController, andMovie movie: Movie) {
        self.movie = movie
        self.topNavigationController = navigationController
        self.navigationController = UINavigationController()
    }
    
    private func showMovieDetails() {
        let movieDetailsViewModel = MovieDetailsViewModel(with: movie)
        let movieDetailsView = MovieDetailsView(with: movieDetailsViewModel)
        movieDetailsView.delegate = self
        navigationController.viewControllers = [movieDetailsView]
        topNavigationController.present(navigationController, animated: true, completion: nil)
    }
    
}
extension MovieDetailsCoordinator: Coordinator {
    
    func start() {
        showMovieDetails()
    }
    
}

extension MovieDetailsCoordinator: MovieDetailsViewDelegate {
    
    func movieDetailsViewShouldClose() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
}
