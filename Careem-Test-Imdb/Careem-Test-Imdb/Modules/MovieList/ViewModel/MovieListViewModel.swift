//
//  MovieListViewModel.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 20/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation

typealias MoviesViewModelOutput = (MovieListViewModelImp.Output) -> ()

//MARK: - MovieListViewModel Protocol
protocol MovieListViewModel {
    
    var numberOfRows: Int { get }
    var output: MoviesViewModelOutput? { get set }
    func getMovieListCellViewModel(index : Int) -> MovieListTableCellViewModel
    func didSelectRow(index : Int)
    func viewModelDidLoad()
    func tableViewDidReachToEnd()
    func didCancelFiltering()
    func didSelectFiltering(with date: Date)
    func onTapOnResetOrFilterButton()
}

//MARK: - MovieListViewModel Implementation
final class MovieListViewModelImp: MovieListViewModel {
    
    //MARK: - View Output Bindings
    enum Output {
        case reloadMovies
        case showActivityIndicator(show: Bool)
        case showDatePicker(show: Bool)
        case showFilterImage(show: Bool)
        case showError(error: Error)
    }
    
    //MARK: - Injected Properties
    var movieService: MovieListService!
    
    //MARK: - Stored Properties
    var output: MoviesViewModelOutput?
    private var pageCount = 1
    private var totalPages: Int = 1
    private var isFetching = false
    
    //MARK: - Observables Properties
    var isFilteringActive: Bool = false {
        didSet {
            output?(.showFilterImage(show: isFilteringActive))
        }
    }
    private var allMovieListViewModels = [MovieListTableCellViewModel]() {
        didSet {
            output?(.reloadMovies)
        }
    }
    private var filteredMovieListViewModels = [MovieListTableCellViewModel]()  {
        didSet {
            output?(.reloadMovies)
        }
    }
    
    //MARK: - Computed Properties
    private var movieDataSourceViewModels: [MovieListTableCellViewModel] {
        if isFilteringActive {
            return filteredMovieListViewModels
        }
        return allMovieListViewModels
    }
    var numberOfRows: Int {
        return movieDataSourceViewModels.count
    }
    
   
    //MARK: - View Input Muatate Methods
    func viewModelDidLoad() {
        getUpcomingMovies()
    }
    func tableViewDidReachToEnd() {
        getUpcomingMovies()
    }
    func didSelectFiltering(with date: Date) {
        activateFilter(with: date)
    }
    func onTapOnResetOrFilterButton() {
        (isFilteringActive) ?  clearFilter() : output?(.showDatePicker(show: true))
    }
    func didCancelFiltering() {
        output?(.showDatePicker(show: false))
    }
    
    
    //MARK: - View Input Action Methods
    func getMovieListCellViewModel(index : Int) -> MovieListTableCellViewModel {
        return movieDataSourceViewModels[index]
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
    
    //MARK: - VPrivate Methods
    private func activateFilter(with date: Date) {
        isFilteringActive = true
        output?(.showDatePicker(show: false))
        let releaseDateFormat    = "yyyy-MM-dd"
        filteredMovieListViewModels = allMovieListViewModels.filter({ $0.movieReleaseDate! == date.stringValue(format: releaseDateFormat) })
        
    }
    private func clearFilter() {
        isFilteringActive = false
        filteredMovieListViewModels.removeAll()
        
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
        allMovieListViewModels.append(contentsOf: movieListTableCellViewModels)
        
    }
    
    func didSelectRow(index: Int) {
    
    }
}


extension Date {
    func stringValue(format: String) -> String? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
