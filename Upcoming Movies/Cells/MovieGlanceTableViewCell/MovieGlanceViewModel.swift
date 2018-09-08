//
//  MovieGlanceViewModel.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MovieGlanceViewModel: ViewModel {
    
    // MARK: - Constants
    private static let emptyMovieOverviewText: String = """
                                                        ——————————————
                                                        ———————————
                                                        ———————————————————————————
                                                        """
    private static let emptyReleaseDateText: String =  "——————"
    
    private static let movieDataFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()
    private static let displayDataFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter
    }()
    
    // MARK: - Data
    private var movie: Movie!
    
    private var posterImage: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.didUpdate?()
            }
        }
    }
    
    
    // MARK: - Initializers
    init(withMovie movie: Movie) {
        self.movie = movie
    }
    
    // MARK: - Properties
    var moviePosterImage: UIImage {
        if let posterImage = posterImage {
            return posterImage
        }
        return #imageLiteral(resourceName: "icon-movie")
    }
    var moviePosterImageContentMode: UIViewContentMode {
        if posterImage != nil {
            return .scaleAspectFill
        }
        return .center
    }
    
    var movieTitle: String {
        return movie.title
    }
    var movieReleaseDate: String {
        if let date = MovieGlanceViewModel.movieDataFormatter.date(from: movie.releaseDate) {
            return MovieGlanceViewModel.displayDataFormatter.string(from: date)
        }
        return MovieGlanceViewModel.emptyReleaseDateText
    }
    var movieOverview: String {
        if movie.overview.removeNewLines.isEmpty {
            return MovieGlanceViewModel.emptyMovieOverviewText
        }
        return movie.overview
    }
    var movieOverviewOpacity: CGFloat {
        if movie.overview.removeNewLines.isEmpty {
            return 0.15
        }
        return 1
    }
    var movieGenres: [Genre] {
        return GenreStorage.shared.getGenres(forIds: movie.genreIds ?? [])
    }
    var movieGenresCount: Int {
        return movie.genreIds?.count ?? 0
    }
    
    func getGenreTitleViewModel(forIndexPath indexPath: IndexPath) -> GenreTitleViewModel? {
        if indexPath.row >= movieGenres.count { return nil }
        return GenreTitleViewModel(withGenre: movieGenres[indexPath.row])
    }
    
    // MARK: - Actions
    func update() {
        self.isUpdating = true
        self.isUpdating = false
        
        // TODO: Fix this VVV
        if let posterPath = movie.backdropPath {
            ImageRequester.requestImage(forURL: MovieDbAPI.getImageUrl(forImagePath: posterPath)) { [weak self] (image) in
                guard let `self` = self else { return }
                self.posterImage = image
            }
        }
    }
    
}
