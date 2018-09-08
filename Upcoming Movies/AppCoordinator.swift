//
//  AppCoordinator.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/7/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    let window: UIWindow
    var navigationController: UINavigationController
    private(set) var childCoordinator: Coordinator?
    
    init(withWindow window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        childCoordinator = MoviesListCoordinator(withNavigationController: navigationController)
        childCoordinator?.start()
    }
    
}
