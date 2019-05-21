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
    
    @IBOutlet weak var pickerViewBottomConstraint: NSLayoutConstraint!
    //MARK: - Outlets
    @IBOutlet weak var movieListTableview: UITableView!
    @IBOutlet weak var datePickerView: DatePickerView!

    
    //MARK: - Properties
    let viewModel = MovieListViewModelImp()
    fileprivate let movieListCellId = "MovieListTableViewCell"
    
    //MARK: - View Life cycle Method
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupTableView()
        bindViewModelOutput()
        viewModel.viewModelDidLoad()
    }
    
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        showDatePicker()
      

    }
  
    //MARK: - Methods
    private func setupTableView() {
        //Use extension
        datePickerView.delegate = self
        let nibMovieListCell = UINib(nibName: "MovieListTableViewCell", bundle: Bundle.main)
        self.movieListTableview.register(nibMovieListCell, forCellReuseIdentifier: self.movieListCellId)
    }
    
    func bindViewModelOutput() {
        viewModel.output = { [weak self] output in
            
            guard let self = self else { return }
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
        
        guard let movieListCell = tableView.dequeueReusableCell(withIdentifier: self.movieListCellId) as? MovieListTableViewCell,
            let cellViewModel = viewModel.getMovieListCellViewModel(index: indexPath.row) else {
            return UITableViewCell()
        }
        
        movieListCell.populateWithViewModel(cellViewModel: cellViewModel)
        return movieListCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(index: indexPath.row)
    }
}

extension MovieListViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY =  scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > (contentHeight - scrollView.frame.height) {
             viewModel.tableViewDidReachToEnd()
        }
    }
}

// MARK: - Date Picker & Filter
extension MovieListViewController: DatePickerViewDelegate {
    
    
    func showDatePicker() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.pickerViewBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    func hideDatePicker() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.pickerViewBottomConstraint.constant = -300
            self.view.layoutIfNeeded()
        })
    }
    
    func datePickerDidCancel(_ sender: DatePickerView) {
        //cancelFilter()
    }
    
    func datePicker(_ sender: DatePickerView, didSelect date: Date) {
        hideDatePicker()
       // filterMovies(forDate: date)
    }
}
