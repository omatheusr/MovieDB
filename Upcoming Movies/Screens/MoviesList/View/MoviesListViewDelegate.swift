//
//  MoviesListViewDelegate.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

protocol MoviesListViewDelegate: class {
    
    func moviesListViewDidSelectCell(at indexPath: IndexPath)
    
}
