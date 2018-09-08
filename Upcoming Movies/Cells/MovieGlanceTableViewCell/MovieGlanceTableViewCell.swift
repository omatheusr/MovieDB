//
//  MovieGlanceTableViewCell.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/8/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

final class MovieGlanceTableViewCell: AnimatedUITableViewCell {
    
    static func dequeueCell(forTableView tableView: UITableView, usingViewModel viewModel: MovieGlanceViewModel?) -> MovieGlanceTableViewCell {
        
        var cell: MovieGlanceTableViewCell! = tableView.dequeueReusableCell(withIdentifier: String(describing: self)) as? MovieGlanceTableViewCell
        
        if cell == nil {
            tableView.register(UINib(nibName: String(describing: self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: self))
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: self)) as? MovieGlanceTableViewCell
        }
        
        cell.viewModel = viewModel
        
        return cell
    }
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: MovieGlanceViewModel? {
        didSet {
            viewModel?.didUpdate = { [weak self, weak viewModel] in
                guard let `self` = self, let viewModel = viewModel else { return }
                
                self.imgPoster?.image = viewModel.moviePosterImage
                self.imgPoster?.contentMode = viewModel.moviePosterImageContentMode
                
                self.lblTitle?.text = viewModel.movieTitle
                self.lblReleaseDate?.text = viewModel.movieReleaseDate
                
                self.lblOverview?.text = viewModel.movieOverview
                self.lblOverview?.alpha = viewModel.movieOverviewOpacity
                self.collectionView?.reloadData()
            }
            viewModel?.update()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        GenreTitleCollectionViewCell.registerCell(forCollectionView: collectionView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgPoster?.image = nil
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
        return GenreTitleCollectionViewCell.dequeueCell(forCollectionView: collectionView, andIndexPath: indexPath, usingViewModel: viewModel?.getGenreTitleViewModel(forIndexPath: indexPath))
    }
    
}

extension MovieGlanceTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // TODO: Fix this VVV
        let sss = (12 + (viewModel?.movieGenres[indexPath.row].name.count ?? 0) * 8)
        
        return CGSize(width: sss, height: 26)
    }
    
}
