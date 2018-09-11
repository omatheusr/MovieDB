//
//  HeaderImageView.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class HeaderImageView: UIView, Instantiable {
    
    weak var delegate: HeaderImageViewDelegate?
    
    static let height: CGFloat = 270
    static let minHeight: CGFloat = 160
    
    private var top: CGFloat = 0
    private var width: CGFloat {
        return superview?.bounds.width ?? 0
    }
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    
    @IBAction func btCloseTouchUpInsideAction(button: UIButton) {
        delegate?.headerViewShouldExecuteCloseAction()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        UIView.parallax(views: imgBack)
    }
    
    private func update(with height: CGFloat) {
        frame = CGRect(x: 0, y: -top, width: width, height: height)
    }
    
    func configure(in view: UIView) {
        top = view.safeAreaInsets.top
        
        view.addSubview(self)
        
        update(with: HeaderImageView.height)
    }
    
    func update(for yOffset: CGFloat) {
        let y = HeaderImageView.height - (yOffset + HeaderImageView.height)
        let height = max(y, top + HeaderImageView.minHeight)
        
        update(with: height)
    }

}
