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
    var isUpdating: Bool = false
    
    func update() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.didUpdate?()
        }
    }
    
}
