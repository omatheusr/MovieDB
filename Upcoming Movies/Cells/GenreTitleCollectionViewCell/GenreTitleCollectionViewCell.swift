//
//  GenreTitleCollectionViewCell.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

class GenreTitleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblGenreTitle: UILabel!
    
    var viewModel: GenreTitleViewModel? {
        didSet {
            viewModel?.didUpdate = { [weak self] in
                guard let `self` = self else { return }
                self.lblGenreTitle?.text = self.viewModel?.genreTitle
            }
            viewModel?.update()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblGenreTitle.text = String()
    }

}
