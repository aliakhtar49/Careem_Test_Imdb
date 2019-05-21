//
//  MovieListViewModel.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 20/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation

typealias MoviesViewModelOutput = (MovieListViewModelImp.Output) -> ()

protocol MovieListViewModel {
    var numberOfRows: Int { get }
    var output: MoviesViewModelOutput? { get set }
    func getMovieListCellViewModel(index : Int) -> MovieListTableCellViewModel?
    func didSelectRow(index : Int)
}

//MARK: - MovieListViewModel
class MovieListViewModelImp: MovieListViewModel {
    
    enum Output {
        case reloadMovies
        case showActivityIndicator(show: Bool)
        case showError(error: Error)
    }
    
    //MARK: - Properties
    var output: MoviesViewModelOutput?
    
    private var movieService = MovieListServiceImpl()
    private var pageCount = 1
    private var movieListCellViewModels = [MovieListTableCellViewModel]()
    private var totalPages: Int = 1
    private var isFetching = false
    
    var numberOfRows: Int {
        return movieListCellViewModels.count
    }
    
    func viewModelDidLoad() {
        getUpcomingMovies()
    }
    
    //MARK: - Methods
    func getMovieListCellViewModel(index : Int) -> MovieListTableCellViewModel? {
        return movieListCellViewModels[index]
    }
    
    func tableViewDidReachToEnd() {
        getUpcomingMovies()
    }
    
    func getUpcomingMovies() {
        if pageCount <= totalPages {
            isFetching = true
            
            pageCount += 1 
   
            movieService.getUpcomingMovies(on: pageCount) { [weak self] (result) in
                
                guard let self = self else { return }
                
                self.isFetching = false
                switch result {
                case .success(let upcomingMovies):
                    self.upcomingListFetch(with: upcomingMovies)
                    
                case .failure(let error):
                    self.output?(.showError(error: error))
                }
                
            }
        }
    }
    
    func upcomingListFetch(with data: UpcomingMovies) {
        
        guard let results = data.results,
            let pageCount = data.page,
            let totalPages = data.total_pages else {
            return
        }
  
        self.pageCount = pageCount
        self.totalPages = totalPages
        
        let movieListTableCellViewModels =  results.map { (movie) -> MovieListTableCellViewModel in
            MovieListTableCellViewModel(movieTitleText: movie.title, movieDescription: movie.overview, moviePosterUrl: movie.poster_path, movieReleaseDate: movie.release_date)
        }
        movieListCellViewModels.append(contentsOf: movieListTableCellViewModels)
        
        output?(.reloadMovies)
    }
    
    func didSelectRow(index: Int) {
    
    }
}

