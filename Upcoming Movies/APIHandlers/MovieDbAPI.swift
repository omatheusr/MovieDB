//
//  MovieDbAPI.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/7/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import Foundation

enum MovieDbAPI: String {
    private static let baseUrl: String = "https://api.themoviedb.org/3"
    private static let apiKey: String = "1f54bd990f1cdfb230adb312546d765d"
    
    case upcomingMovies = "/movie/upcoming"
    case genreList = "/genre/movie/list"
    
    
    func getUrl(withParameters parameters: [String: String] = [:]) -> URL! {
        var urlParams: String = ""
        for (paramKey, paramValue) in parameters {
            urlParams += "&\(paramKey)=\(paramValue)"
        }
        
        return URL(string: "\(MovieDbAPI.baseUrl)\(self.rawValue)?api_key=\(MovieDbAPI.apiKey)\(urlParams)")
    }
    
    static func getImageUrl(forImagePath imagePath: String) -> URL! {
        return URL(string: "https://image.tmdb.org/t/p/\(imagePath)")
    }
    
}
