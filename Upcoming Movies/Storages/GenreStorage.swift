//
//  GenreStorage.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import Foundation

final class GenreStorage {
    let language: String = "en-US"
    
    static let shared: GenreStorage = GenreStorage()
    
    private var genres: [Genre] = []
    private var isUpdating: Bool = false
    
    var isEmpty: Bool {
        return genres.isEmpty
    }
    
    func getGenre(for id: Int) -> Genre? {
        return genres.first(where: { $0.id == id })
    }
    
    func getGenres(for ids: [Int]) -> [Genre] {
        return genres.filter({ ids.contains($0.id) })
    }
    
    @discardableResult
    func loadIfNeeded(completion: @escaping () -> Void) -> Bool {
        if isUpdating { return false }
        if !genres.isEmpty { return false }
        
        genres = []
        isUpdating = true
        MovieDb.requestGenreList(language: language, success: { (genresList) in
            self.genres = genresList.genres
            self.isUpdating = false
            completion()
        }, failure: { [weak self] (_) in
            guard let `self` = self else { return }
            self.isUpdating = false
            completion()
        })
        return true
    }

}
