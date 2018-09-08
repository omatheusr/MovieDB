//
//  ViewModel.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import Foundation

protocol ViewModelAction { }

class ViewModel {
    
    var didUpdate: (() -> Void)?
    var didFail: ((Error) -> Void)?
    
    func execute(action: ViewModelAction) { }
    
}
