//
//  GenreOverviewCell.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/11/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class GenreOverviewCell: UITableViewCell {
    
    private weak var formatter: MovieFormatter!
    
    // MARK: - Outlets
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Events
    override func awakeFromNib() {
        super.awakeFromNib()
        
        GenreTitleCell.registerCell(forCollectionView: collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        selectionStyle = .none
    }
    
    func configure(with formatter: MovieFormatter) {
        self.formatter = formatter
        lblOverview.text = formatter.movieOverview
        lblOverview.alpha = formatter.movieOverviewOpacity
        
        collectionView.reloadData()
    }
}

extension GenreOverviewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return formatter?.movieGenresCount ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GenreTitleCell! = GenreTitleCell.dequeueCell(forCollectionView: collectionView, forIndexPath: indexPath)
        cell.lblGenreTitle.text = formatter.getGenreName(for: indexPath.row)
        return cell
    }
    
}

extension GenreOverviewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = formatter.getGenreNameWidth(for: indexPath.row)
        return CGSize(width: width, height: 26)
    }
    
}
