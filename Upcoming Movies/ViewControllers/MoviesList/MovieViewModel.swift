//
//  MovieViewModel.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

class MovieViewModel: ViewModel {
    private static let emptyTitle = "—————————————"
    private static let emptyOverview =  """
                                        ——————————————
                                        ———————————
                                        ———————————————————————————
                                        """
    private static let emptyReleaseDate = "——————"
    
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
    
    
    
    weak var movie: Movie? {
        didSet {
            update()
        }
    }
    private var cachedPosterImage: UIImage?
    private var cachedBackImage: UIImage?
    
    var movieId: Int {
        return movie?.id ?? -1
    }
    
    var movieTitle: String {
        return movie?.title ?? MovieViewModel.emptyTitle
    }
    
    var movieOverview: String {
        guard let overview = movie?.overview, hasOverview else {
            return MovieViewModel.emptyOverview
        }
        return overview
    }
    
    var movieReleaseDate: String {
        if let date = MovieViewModel.movieDataFormatter.date(from: movie?.releaseDate ?? "") {
            return MovieViewModel.displayDataFormatter.string(from: date)
        }
        return MovieViewModel.emptyReleaseDate
    }
    
    var movieGenreIds: [Int] {
        return movie?.genreIds ?? []
    }
    var movieGenres: [Genre] {
        return GenreStorage.shared.getGenres(forIds: movieGenreIds)
    }
    var movieGenresCount: Int {
        return movieGenres.count
    }
    var movieOverviewOpacity: CGFloat {
        return hasOverview ? 1 : 0.15
    }
    var movieTitleOpacity: CGFloat {
        return hasTitle ? 1 : 0.15
    }
    var movieReleaseDateOpacity: CGFloat {
        return hasReleaseDate ? 1 : 0.15
    }
    var moviePosterContentMode: UIViewContentMode {
        return hasPosterImage ? .scaleAspectFill : .center
    }
    
    var hasBackdropImage: Bool {
        return cachedBackImage != nil
    }
    var hasPosterImage: Bool {
        return cachedPosterImage != nil
    }
    var hasOverview: Bool {
        return !(movie?.overview.removeNewLines.isEmpty ?? true)
    }
    var hasTitle: Bool {
        return !(movie?.title.removeNewLines.isEmpty ?? true)
    }
    var hasReleaseDate: Bool {
        return !(movie?.releaseDate.removeNewLines.isEmpty ?? true)
    }
    
    
    func movieBackdropImage(withSize size: MovieDbImage.ImageSize = .small, downloadCompletion: @escaping (UIImage) -> Void) {
        if cachedBackImage == nil, let backdropPath = movie?.backdropPath {
            MovieDbImage.request(forPath: backdropPath, withSize: size) { [weak self] (image) in
                self?.cachedBackImage = image
                downloadCompletion(image ?? #imageLiteral(resourceName: "icon-movie"))
            }
        }
        downloadCompletion(cachedBackImage ?? #imageLiteral(resourceName: "icon-movie"))
    }
    func moviePosterImage(withSize size: MovieDbImage.ImageSize = .small, downloadCompletion: @escaping (UIImage) -> Void) {
        
        if cachedPosterImage == nil, let postPath = movie?.posterPath {
            MovieDbImage.request(forPath: postPath, withSize: size) { [weak self] (image) in
                self?.cachedPosterImage = image
                downloadCompletion(image ?? #imageLiteral(resourceName: "icon-movie"))
            }
        }
        downloadCompletion(cachedPosterImage ?? #imageLiteral(resourceName: "icon-movie"))
    }
    
    static func genreTitleSize(forGenreTitle title: String?) -> CGFloat {
        return CGFloat(16 + (title?.count ?? 0) * 9)
    }
}

extension MovieViewModel: Equatable {
    
    static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
        return lhs.movieId == rhs.movieId
    }
    
}
