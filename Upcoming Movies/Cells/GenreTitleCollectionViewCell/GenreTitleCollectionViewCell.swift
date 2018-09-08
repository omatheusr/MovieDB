//
//  GenreTitleCollectionViewCell.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

class GenreTitleCollectionViewCell: UICollectionViewCell {
    
    static func registerCell(forCollectionView collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: String(describing: self), bundle: Bundle.main), forCellWithReuseIdentifier: String(describing: self))
    }
    
    static func dequeueCell(forCollectionView collectionView: UICollectionView, andIndexPath indexPath: IndexPath, usingViewModel viewModel: GenreTitleViewModel?) -> GenreTitleCollectionViewCell {
        
        let cell: GenreTitleCollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: self), for: indexPath) as? GenreTitleCollectionViewCell
        
        cell.viewModel = viewModel
        
        return cell
    }
    
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
