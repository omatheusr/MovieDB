//
//  MovieDetailsCoordinator.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MovieDetailsCoordinator: Coordinator {
    
    private(set) var topNavigationController: UINavigationController
    private(set) var navigationController: UINavigationController
    private(set) var childCoordinator: Coordinator?
    
    private let movie: Movie
    
    init(withNavigationController navigationController: UINavigationController, andMovie movie: Movie) {
        self.movie = movie
        self.topNavigationController = navigationController
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let movieDetailsViewModel = MovieDetailsViewModel(withMovie: movie)
        let movieDetailsViewController = MovieDetailsViewController(withViewModel: movieDetailsViewModel)
        movieDetailsViewController.delegate = self
        
        navigationController.viewControllers = [movieDetailsViewController]
        
        topNavigationController.present(navigationController, animated: true, completion: nil)
    }
    
}

extension MovieDetailsCoordinator: MovieDetailsViewControllerDelegate {
    
    func movieDetailsViewControllerDidTapCloseButton() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
}
