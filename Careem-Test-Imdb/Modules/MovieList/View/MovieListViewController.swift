//
//  MovieListViewController.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 20/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    let viewModel = MovieListViewModel()

    override func viewDidLoad() {

        super.viewDidLoad()
        
        
    }
    func bindViewModelOutput() {
        viewModel.output = { [unowned self] output in
            switch output {
            case .reloadMovies: break
               //self.collectionView.reloadData()
            case .showActivityIndicator(let show): break
               // show ? ProgressHUD.show(viewController: self) : ProgressHUD.dismiss()
            case .showError(let error): break
              //  UIAlertController.showAlert(with: error)
            }
        }
    }
    
}
