//
//  Coordinator.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/7/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    
    var navigationController: UINavigationController { get }
    var childCoordinator: Coordinator? { get }
    
    func start()
    
}
