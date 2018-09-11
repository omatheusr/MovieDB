//
//  StringExtension.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import Foundation

extension String {
    
    var removeNewLines: String {
        return self.replacingOccurrences(of: "\n", with: "")
                   .replacingOccurrences(of: "\r", with: "")
    }
    
}
