//
//  ViewController.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 20/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let service =  MovieListServiceImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
        service.getUpcomingMovies(on: 1) { (upcomingMovies, error) in
            print(upcomingMovies)
            print(error)
        }
      

        
    }
    



}

