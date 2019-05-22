//
//  MockMovieListDataProvider.swift
//  Careem-Test-ImdbTests
//
//  Created by Ali Akhtar on 22/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import UIKit
@testable import Careem_Test_Imdb


class  MockMovieListDataProvider: MovieListDataProvider {
    var delegate: MovieListDataProviderDelegate?
    
    var closure: (() -> ())?
    
    func providePaginatedUpcomingMovies() {
        closure?()
    }
    
    
}
