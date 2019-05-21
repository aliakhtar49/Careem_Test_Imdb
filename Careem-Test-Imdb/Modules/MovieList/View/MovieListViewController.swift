//
//  MovieListViewController.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 20/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import UIKit

//MARK: - MovieListViewController
class MovieListViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var movieListTableview: UITableView!
    
    //MARK: - Properties
    let viewModel = MovieListViewModel()
    fileprivate let movieListCellId = "MovieListTableViewCell"
    

    
    //MARK: - View Life cycle Method
    override func viewDidLoad() {

        super.viewDidLoad()
        setupTableView()
        bindViewModelOutput()
        self.getUpcomingMovies()
    
    }
    
    
     //MARK: - Methods
    func getUpcomingMovies() {
        viewModel.getUpcomingMovies()
    }
    private func setupTableView() {
   
        let nibMovieListCell = UINib(nibName: "MovieListTableViewCell", bundle: Bundle.main)
        self.movieListTableview.register(nibMovieListCell, forCellReuseIdentifier: self.movieListCellId)
    }
    
    
    func bindViewModelOutput() {
        viewModel.output = { [unowned self] output in
            switch output {
            case .reloadMovies:
                self.movieListTableview.reloadData()
            case .showActivityIndicator(let show): break
               // show ? ProgressHUD.show(viewController: self) : ProgressHUD.dismiss()
            case .showError(let error): break
             //  UIAlertController.showAlert(with: error.localizedDescription)
            }
        }
    }
    
}


//MARK: - UITableViewDataSource
extension MovieListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let movieListCell = tableView.dequeueReusableCell(withIdentifier: self.movieListCellId) as! MovieListTableViewCell
        
        let cellViewModel = viewModel.getMovieListCellViewModel(index: indexPath.row)
        movieListCell.populateWithViewModel(cellViewModel: cellViewModel)
        return movieListCell
    }
    

}
