//
//  MovieDetailViewModel.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 21/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation

typealias MovieDetailModelOutput = (MovieDetailViewModelImp.Output) -> ()

//MARK: - MovieDetailViewModel Protocol
protocol MovieDetailViewModel {
    
    var output: MovieDetailModelOutput? { get set }
    func viewDidLoad()

}

//MARK: - MovieDetailViewModel Implementation
final class MovieDetailViewModelImp: MovieDetailViewModel {

    //MARK: - View Output Bindings
    enum Output {
        case showMovieBannerImageView(url: URL)
        case showMovieTitle(title: String)
        case showMovieReleaseDate(releaseDate: String)
        case showMovieDescription(description: String)
        case showMovieGenre(genre: String)
        case showMovieRating(rating: String)
        case showMovieLanguage(lang: String)
    }
    
    //MARK: - Stored Properties
    var output: MovieDetailModelOutput?
    private var movie: Movie?
    
    
    //MARK: - Computed Properties
    var bannerImageUrl: URL? {
        return URL(string: Constants.IMDB_IMAGE_BASE_URL + (movie?.poster_path ?? ""))
    }
  
    
    func viewDidLoad() {
        
        output?(.showMovieDescription(description: movie?.overview ?? ""))
        output?(.showMovieLanguage(lang: "Language = \(movie?.original_language ?? "")"))
        output?(.showMovieRating(rating: "\(movie?.vote_count ?? 0)"))
        output?(.showMovieTitle(title: movie?.title ?? ""))
        showBannerImage()
        showGenre()
        showReleaseDate()
    }
    
    //MARK: - Init
    init(_ movie: Movie?) {
        self.movie = movie
    }
    
    //MARK: - Private Method
    private func showBannerImage() {
        
        guard let bannerImageUrl = self.bannerImageUrl else { return }
        output?(.showMovieBannerImageView(url: bannerImageUrl))
    }
    
    private func showGenre() {
        
        guard let genres = movie?.genre_ids else { return }
        let str = genres.map { String($0) }
            .joined(separator: " ,")
        output?(.showMovieGenre(genre:"Genres = \(str)"))
    }
    
    private func showReleaseDate() {
        output?(.showMovieReleaseDate(releaseDate: (DateUtility.convertShortToLong(from: movie?.release_date)) ?? ""))
    }
}
