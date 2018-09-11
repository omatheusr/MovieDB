//
//  MoviesListViewModelDelegate.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

protocol MoviesListViewModelDelegate: class {
    
    func movieListViewModelDidReceiveError(_ error: Error)
    
    func movieListViewModelDidUpdateData()
    
}
