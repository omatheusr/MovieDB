//
//  MovieGlanceTableViewCell.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MovieGlanceTableViewCell: AnimatedUITableViewCell {
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var viewModel: MovieGlanceViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            viewModel.didUpdate = { [weak self, weak viewModel] in
                guard let `self` = self, let viewModel = viewModel, self.viewModel == viewModel else { return }
                
                self.imgPoster?.image = #imageLiteral(resourceName: "icon-movie")
                
                self.lblTitle.text = viewModel.movieTitle
                self.lblTitle?.alpha = viewModel.movieTitleOpacity
                
                self.lblReleaseDate?.text = viewModel.movieReleaseDate
                self.lblReleaseDate?.alpha = viewModel.movieReleaseDateOpacity
                
                self.lblOverview?.text = viewModel.movieOverview
                self.lblOverview?.alpha = viewModel.movieOverviewOpacity
                
                self.collectionView?.reloadData()
                
                viewModel.moviePosterImage(downloadCompletion: { [weak self, weak viewModel] (image) in
                    guard let `self` = self, let viewModel = viewModel, let imgPoster = self.imgPoster, self.viewModel == viewModel else { return }
                    imgPoster.transition {
                        imgPoster.image = image
                        imgPoster.contentMode = viewModel.moviePosterContentMode
                    }
                })
            }
            viewModel.update()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        GenreTitleCollectionViewCell.registerCell(forCollectionView: collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    private func reset() {
        imgPoster?.image = #imageLiteral(resourceName: "icon-movie")
        imgPoster?.contentMode = .center
        lblTitle?.text = String()
        lblReleaseDate?.text = String()
        lblOverview?.text = String()
        collectionView?.reloadData()
    }
    
}

extension MovieGlanceTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.movieGenresCount ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GenreTitleCollectionViewCell! = GenreTitleCollectionViewCell.dequeueCell(forCollectionView: collectionView, forIndexPath: indexPath)
        cell.viewModel = viewModel?.getGenreTitleViewModel(forIndexPath: indexPath)
        return cell
    }
    
}

extension MovieGlanceTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = MovieViewModel.genreTitleSize(forGenreTitle: viewModel?.movieGenres[indexPath.row].name)
        return CGSize(width: width, height: 26)
    }
    
}
