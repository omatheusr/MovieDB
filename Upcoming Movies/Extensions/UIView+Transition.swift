//
//  UIView+Transition.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

extension UIView {
    
    func transition(withDuration duration: TimeInterval = 0.6, transitions: @escaping () -> Void) {
        DispatchQueue.main.async {
            UIView.transition(with: self, duration: duration, options: [.curveEaseOut, .transitionCrossDissolve, .beginFromCurrentState], animations: {
                transitions()
            }, completion: nil)
        }
    }
    
}
