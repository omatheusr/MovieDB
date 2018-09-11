//
//  MovieDb.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/7/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import Foundation

final class MovieDb {
    
    private static func request<T>(url: URL, method: Requester.HttpMethod, expectingResponseOfType type: T.Type, success: @escaping (T) -> Void, failure: @escaping (MovieDbError) -> Void) where T: Decodable {
        let decoder = JSONDecoder()
        
        Requester.shared.execute(requestForURL: url, usingHttpMethod: method) { (resp) in
            switch resp {
            case .success(let sData, let sError, _):
                do {
                    success(try decoder.decode(type, from: sData))
                } catch {
                    failure((try? decoder.decode(MovieDbError.self, from: sData)) ?? MovieDbError(error: sError))
                }
            case .fail(_, let fError, _):
                failure(MovieDbError(error: fError))
            }
        }
    }
    
    static func requestUpcomingMovies(forPage page: Int, andLanguage language: String, success: @escaping (MoviesList) -> Void, failure: @escaping (MovieDbError) -> Void) {
        
        let parameters = ["page": String(page),
                          "language": language]
        
        MovieDb.request(url: MovieDbAPI.upcomingMovies.getUrl(withParameters: parameters), method: .get, expectingResponseOfType: MoviesList.self, success: success, failure: failure)
    }
    
    static func requestGenreList(language: String, success: @escaping (GenresList) -> Void, failure: @escaping (MovieDbError) -> Void) {
        
        let parameters = ["language": language]
        
        MovieDb.request(url: MovieDbAPI.genreList.getUrl(withParameters: parameters), method: .get, expectingResponseOfType: GenresList.self, success: success, failure: failure)
        
    }
    
    static func requestImage(forPath urlPath: String, completion: @escaping (Data?) -> Void) {
        guard let imageUrl = MovieDbAPI.getImageUrl(forImagePath: urlPath) else {
            completion(nil)
            return
        }

        Requester.shared.execute(requestForURL: imageUrl, usingHttpMethod: .get) { (response) in
            if case .success(let data, _, _) = response {
                completion(data)
            } else {
                completion(nil)
            }
        }
        
    }
    
}
