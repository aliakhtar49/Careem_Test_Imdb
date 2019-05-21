//
//  MovieListViewController.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 20/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import UIKit

//MARK: - MovieListViewController
final class MovieListViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    @IBOutlet weak var pickerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var movieListTableview: UITableView!
    @IBOutlet weak var datePickerView: DatePickerView!


    //MARK: - Properties
    var viewModel: MovieListViewModel!
 
    
    //MARK: - View Life cycle Method
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
        bindViewModelOutput()
        viewModel.viewModelDidLoad()
    }
    
    //MARK: - Outlet Actions
    @IBAction func onRightBarButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.onTapOnResetOrFilterButton()
    }
  
    //MARK: - Methods
    private func setupUI() {
        
        datePickerView.delegate = self
        self.movieListTableview.register(cellType: MovieListTableViewCell.self,bundle: Bundle.main)
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
            case .showDatePicker(let show):
                (show) ? self.showDatePicker()  :  self.hideDatePicker()
            case .showFilterImage(let show):
                self.rightBarButton.image  = ( show )  ? UIImage(named: "reset.png") : UIImage(named: "filter")
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
        
        let movieListCell: MovieListTableViewCell  = tableView.dequeueReusableCell(for: indexPath)
        let cellViewModel = viewModel.getMovieListCellViewModel(index: indexPath.row)
        movieListCell.populateWithViewModel(cellViewModel: cellViewModel)
        
        return movieListCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(index: indexPath.row)
    }
}

// MARK: - UIScrollViewDelegate (Infinite Scrolling)
extension MovieListViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if scrollView.isReachToBottom() {
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
        viewModel.didCancelFiltering()
    }
    
    func datePicker(_ sender: DatePickerView, didSelect date: Date) {
        viewModel.didSelectFiltering(with: date)

    }
}




