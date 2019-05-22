//
//  MovieListTableViewCell.swift
//  Careem-Test-ImdbTests
//
//  Created by Ali Akhtar on 21/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import UIKit
import Kingfisher

//MARK: - MovieListTableViewCell
class MovieListTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    
    //MARK: - Methods
    func populateWithViewModel(cellViewModel: MovieListTableCellViewModel) {
        
        movieTitle.text = cellViewModel.movieTitleText
        movieReleaseDate.text = cellViewModel.movieReleaseDate 
        movieDescription.text = cellViewModel.movieDescription 
        let url = URL(string: cellViewModel.moviePosterUrl )
        posterImageView.kf.setImage(with: url)
            
        }
    

}
