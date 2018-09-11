//
//  Movie.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/7/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import Foundation

final class Movie: Decodable {
    
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    
    var video: Bool?
    var adult: Bool?
    var voteCount: Int?
    var voteAverage: Float?
    var popularity: Float?
    
    var originalLanguage: String?
    var originalTitle: String?
    var genreIds: [Int]?
    var backdropPath: String?
    var posterPath: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        
        case video
        case adult
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case popularity
        
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
    
}

extension Movie: Equatable {

    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
}
