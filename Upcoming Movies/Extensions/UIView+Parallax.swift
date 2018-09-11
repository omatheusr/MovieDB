//
//  UIView+Parallax.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

extension UIView {
    
    static func parallax(minXY min: CGFloat = -20, maxXY max: CGFloat = 20, views: UIView...) {
        for view in views {
            let xAxis = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
            xAxis.minimumRelativeValue = min
            xAxis.maximumRelativeValue = max
            
            let yAxis = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
            yAxis.minimumRelativeValue = min
            yAxis.maximumRelativeValue = max
            
            let xyGroup = UIMotionEffectGroup()
            xyGroup.motionEffects = [xAxis, yAxis]
            view.addMotionEffect(xyGroup)
        }
    }
}
