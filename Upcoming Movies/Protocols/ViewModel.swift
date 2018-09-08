//
//  ViewModel.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import Foundation

class ViewModel {
    
    var didUpdate: (() -> Void)?
    var didFail: ((Error) -> Void)?
    
    // MARK: - Status Machine
    var isUpdating: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.didUpdate?()
            }
        }
    }
    
}
