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
    var movieListDataProvider: MovieListDataProvider!
    
    //MARK: - Stored Properties
    var output: MoviesViewModelOutput?
    
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
        movieListDataProvider.providePaginatedUpcomingMovies()
    }
    
    //MARK: - Private Methods
    private func activateFilter(with date: Date) {
        isFilteringActive = true
        output?(.showDatePicker(show: false))
        filteredMovieListViewModels = allMovieListViewModels.filter({ $0.movieReleaseDate == date.stringValue(formatter: DateFormatterManger.dateFormatterForReleaseDate) })
        
    }
    private func clearFilter() {
        isFilteringActive = false
        filteredMovieListViewModels.removeAll()
    }


    
    func didSelectRow(index: Int) {
    
    }
}


//MARK: - MovieListDataProviderDelegate Delegate
extension MovieListViewModelImp: MovieListDataProviderDelegate {
    
    func onSuccess(_ upcomingMovies: UpcomingMovies) {

        guard let results = upcomingMovies.results else { return }
        allMovieListViewModels.append(contentsOf: results.map { MovieListTableCellViewModel.init($0) })
    }
    
    func onFailure(_ error: NetworkError) {
         self.output?(.showError(error: error))
    }
    
}

