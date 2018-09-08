//
//  MoviesListCoordinator.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/7/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MoviesListCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    private(set) var childCoordinator: Coordinator?
    
    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.barStyle = .blackTranslucent
        
        let moviesListViewModel = MoviesListViewModel(withMovieStorage: MovieStorage())
        navigationController.viewControllers = [MoviesListViewController(withViewModel: moviesListViewModel)]
    }
    
}
