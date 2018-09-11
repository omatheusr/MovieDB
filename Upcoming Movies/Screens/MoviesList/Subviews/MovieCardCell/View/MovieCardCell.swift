//
//  MovieCardCell.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MovieCardCell: UIAnimatedTableViewCell {
    
    // MARK: - Data
    var viewModel: (MovieCardViewModelProtocol & MovieFormatter)? {
        didSet { viewModel?.delegate = self }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    // MARK: - Actions
    private func reset() {
        imgPoster?.image = #imageLiteral(resourceName: "icon-movie")
        imgPoster?.contentMode = .center
        lblTitle?.text = String()
        lblReleaseDate?.text = String()
        lblOverview?.text = String()
        collectionView?.reloadData()
    }
    
}
extension MovieCardCell: MovieCardViewModelDelegate {
    
    func movieCardViewModelDidUpdateMovie() {
        guard let viewModel = viewModel else {
            return
        }
        
        lblTitle?.alpha = viewModel.movieTitleOpacity
        lblOverview?.alpha = viewModel.movieOverviewOpacity
        lblReleaseDate?.alpha = viewModel.movieReleaseDateOpacity
        
        lblTitle?.text = viewModel.movieTitle
        lblOverview?.text = viewModel.movieOverview
        lblReleaseDate?.text = viewModel.movieReleaseDate
        
        viewModel.getPosterImage { [weak self] (image, contentMode) in
            guard let `self` = self, viewModel.movieId == self.viewModel?.movieId else {
                return
            }
            self.imgPoster?.transition { [weak self] in
                self?.imgPoster?.image = image
                self?.imgPoster?.contentMode = contentMode
            }
        }
        
        collectionView?.reloadData()
    }
    
}

extension MovieCardCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.movieGenresCount ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GenreTitleCell! = GenreTitleCell.dequeueCell(forCollectionView: collectionView, forIndexPath: indexPath)
        cell.lblGenreTitle.text = viewModel?.getGenreName(for: indexPath.row)
        return cell
    }
    
}

extension MovieCardCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let viewModel = viewModel else {
            return .zero
        }
        let width = viewModel.getGenreNameWidth(for: indexPath.row)
        return CGSize(width: width, height: 26)
    }
    
}
