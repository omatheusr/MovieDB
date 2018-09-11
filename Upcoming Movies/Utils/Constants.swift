//
//  Constants.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import Foundation

final class Contants {
    static let emptyTitle = "—————————————"
    static let emptyOverview =  """
                                ——————————————
                                ———————————
                                ———————————————————————————
                                """
    static let emptyReleaseDate = "——————"
    
    static let movieDataFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()
    static let displayDataFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter
    }()
}
