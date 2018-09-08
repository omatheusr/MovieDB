//
//  AnimatedUITableViewCell.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

class AnimatedUITableViewCell: UITableViewCell {

    private let generator = UISelectionFeedbackGenerator()
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        endSelection()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        beginSelection()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        endSelection()
    }
    
    
    private func beginSelection(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState, .curveEaseInOut], animations: { [weak self] in
            
            guard let `self` = self else { return }
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
            
            }, completion: nil)
        generator.prepare()
    }
    private func endSelection(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.beginFromCurrentState, .curveEaseInOut], animations: { [weak self] in
            
            guard let `self` = self else { return }
            self.transform = CGAffineTransform.identity
            
            }, completion: completion)
        generator.selectionChanged()
    }
    
}
