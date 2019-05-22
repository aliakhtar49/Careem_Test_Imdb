//
//  MovieDetailViewController.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 21/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import UIKit

//MARK: - MovieDetailViewController
class MovieDetailViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var movieBannerImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    //MARK: - Injected Properties
    var viewModel: MovieDetailViewModel!
    
    
    //MARK: - View Lifcycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModelOutput()
        viewModel.viewDidLoad()
    }
    
    //MARK: - View Binding
    func bindViewModelOutput() {
        viewModel.output = { [weak self] output in
            
            guard let self = self else { return }
            
            switch output {
            case .showMovieBannerImageView(let url):
                self.movieBannerImageView.kf.setImage(with: url)
            case .showMovieTitle(let title):
                self.movieTitle.text = title
            case .showMovieReleaseDate(let releaseDate):
                self.movieReleaseDate.text = releaseDate
            case .showMovieDescription(let description):
                self.movieDescription.text = description
            case .showMovieGenre(let genre):
                self.movieGenre.text = genre
            case .showMovieLanguage(let lang):
                self.movieLanguage.text = lang
            case .showMovieRating(let rating):
                self.movieRating.text = rating
            }
        }
    }


}
