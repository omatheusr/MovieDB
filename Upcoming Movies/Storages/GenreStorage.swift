//
//  GenreStorage.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import Foundation

class GenreStorage {
    
    static let shared: GenreStorage = GenreStorage()
    
    typealias DataType = Genre
    
    private(set) var data: [Genre] = []
    private(set) var isUpdating: Bool = false
    
    let language: String = "en-US"
    
    func loadData(reset: Bool = false, success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        if isUpdating { return }
        
        if !data.isEmpty && !reset {
            success()
            return
        }
        data = []
        isUpdating = true
        MovieDb.requestGenreList(language: language, success: { (genresList) in
            let newGenres = genresList.genres.filter({ [weak self] (genre) -> Bool in
                guard let `self` = self else { return false }
                return !self.data.contains(genre)
            })
            self.data += newGenres
            
            self.isUpdating = false
            success()
        }, failure: { [weak self] (error) in
            guard let `self` = self else { return }
            self.isUpdating = false
            failure(error)
        })
    }
    func loadData(reset: Bool = false, completion: @escaping () -> Void) {
        loadData(reset: reset, success: completion, failure: { _ in
            completion()
        })
    }
    
    func getGenre(forId id: Int) -> Genre? {
        return data.first(where: { $0.id == id })
    }
    func getGenres(forIds ids: [Int]) -> [Genre] {
        return data.filter({ ids.contains($0.id) })
    }

}
