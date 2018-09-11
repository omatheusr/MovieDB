//
//  UIView+SelectionAnimation.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

extension UIView {
    
    func beginSelection(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState, .curveEaseInOut], animations: { [weak self] in
            guard let `self` = self else { return }
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }, completion: completion)
    }
    
    func endSelection(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.beginFromCurrentState, .curveEaseInOut], animations: { [weak self] in
            guard let `self` = self else { return }
            self.transform = CGAffineTransform.identity
        }, completion: completion)
    }
    
}
