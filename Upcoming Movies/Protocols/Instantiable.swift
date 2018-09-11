//
//  Instantiable.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

protocol Instantiable {
    static func instantiate() -> Self!
}

extension Instantiable where Self: UIView {
    static func instantiate() -> Self! {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as? Self
    }
}
