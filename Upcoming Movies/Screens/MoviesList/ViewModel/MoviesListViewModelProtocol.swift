//
//  MoviesListViewModelProtocol.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

protocol MoviesListViewModelProtocol: class {
    
    var delegate: MoviesListViewModelDelegate? { get set }
    
    var numberOfSections: Int { get }
    var numberOfRows: Int { get }
    var heightForRow: CGFloat { get }
    
    func load()
    
    func willDisplayCell(at indexPath: IndexPath)
    
    func getMovieCardViewModel(for indexPath: IndexPath) -> MovieCardViewModel?
    
}
