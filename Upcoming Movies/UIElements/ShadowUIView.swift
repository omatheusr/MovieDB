//
//  ShadowUIView.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class ShadowUIView: UIView {
    
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable var shadowRadius: Float = 4 {
        didSet {
            layer.shadowRadius = CGFloat(shadowRadius)
        }
    }
    @IBInspectable var shadowOpacity: Float = 0.6 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    @IBInspectable var shadowOffsetH: Float = 2 {
        didSet {
            layer.shadowOffset = CGSize(width: CGFloat(shadowOffsetW), height: CGFloat(shadowOffsetH))
        }
    }
    @IBInspectable var shadowOffsetW: Float = 0 {
        didSet {
            layer.shadowOffset = CGSize(width: CGFloat(shadowOffsetW), height: CGFloat(shadowOffsetH))
        }
    }
    
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = CGFloat(shadowRadius)
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: CGFloat(shadowOffsetW), height: CGFloat(shadowOffsetH))
    }
    
}
