//
//  MovieGlanceViewModel.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MovieGlanceViewModel: MovieViewModel {
        
    func getGenreTitleViewModel(forIndexPath indexPath: IndexPath) -> GenreTitleViewModel? {
        if indexPath.row >= movieGenresCount { return nil }
        return GenreTitleViewModel(withGenre: movieGenres[indexPath.row])
    }
    
}
