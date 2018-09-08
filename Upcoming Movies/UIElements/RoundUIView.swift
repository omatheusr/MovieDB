//
//  RoundUIView.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class RoundUIView: UIView {
    
    @IBInspectable var cornerRadius: Float = 0 {
        didSet {
            layer.cornerRadius = CGFloat(cornerRadius)
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        layer.masksToBounds = true
        layer.cornerRadius = CGFloat(cornerRadius)
    }
    
}
