//
//  MovieFormatter.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//


import UIKit

protocol MovieFormatter: class {
    
    var movie: Movie? { get set }
    
}

extension MovieFormatter {
    var movieId: Int {
        return movie?.id ?? -1
    }
    
    var movieTitle: String {
        return movie?.title ?? Contants.emptyTitle
    }
    
    var movieOverview: String {
        guard let overview = movie?.overview, hasOverview else {
            return Contants.emptyOverview
        }
        return overview
    }
    
    var movieReleaseDate: String {
        if let date = Contants.movieDataFormatter.date(from: movie?.releaseDate ?? "") {
            return Contants.displayDataFormatter.string(from: date)
        }
        return Contants.emptyReleaseDate
    }
    
    var movieGenreIds: [Int] {
        return movie?.genreIds ?? []
    }
    var movieGenres: [Genre] {
        return GenreStorage.shared.getGenres(for: movieGenreIds)
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
    //    var moviePosterContentMode: UIViewContentMode {
    //        return hasPosterImage ? .scaleAspectFill : .center
    //    }
    
    var hasOverview: Bool {
        return !(movie?.overview.removeNewLines.isEmpty ?? true)
    }
    var hasTitle: Bool {
        return !(movie?.title.removeNewLines.isEmpty ?? true)
    }
    var hasReleaseDate: Bool {
        return !(movie?.releaseDate.removeNewLines.isEmpty ?? true)
    }
    
    func getGenreName(for index: Int) -> String? {
        let genres = movieGenres
        guard genres.count > index else {
            return nil
        }
        return genres[index].name.uppercased()
    }
    
    func getGenreNameWidth(for index: Int) -> CGFloat {
        guard let genreName = getGenreName(for: index) else {
            return 0
        }
        return CGFloat((genreName.count * 8) + 16)
    }
    
    func getPosterImage(completion: @escaping (UIImage, UIViewContentMode) -> Void) {
        getImage(for: movie?.posterPath, completion: completion)
    }
    func getBackdropImage(completion: @escaping (UIImage, UIViewContentMode) -> Void) {
        getImage(for: movie?.backdropPath, completion: completion)
    }
    
    private func getImage(for path: String?, completion: @escaping (UIImage, UIViewContentMode) -> Void) {
        guard let path = path else {
            completion(#imageLiteral(resourceName: "icon-movie"), .center)
            return
        }
        
        let isDownloading = MovieDbImage.request(forPath: path, withSize: MovieDbImage.ImageSize.small) { (image) in
            if let image = image {
                completion(image, .scaleAspectFill)
            } else {
                completion(#imageLiteral(resourceName: "icon-movie"), .center)
            }
        }
        if isDownloading {
            completion(#imageLiteral(resourceName: "icon-movie"), .center)
        }
    }
}
