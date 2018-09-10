//
//  ImageHeaderView.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/9/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

class ImageHeaderView: UIView {

    static func instantiate() -> ImageHeaderView! {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as? ImageHeaderView
    }
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    
    var didClose: (() -> Void)?
    
    @IBAction func btCloseTouchUpInsideAction(button: UIButton) {
        didClose?()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        UIView.parallax(views: imgBack)
    }
    
}
