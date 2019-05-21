//
//  Result.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 20/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation

 //MARK: - Result

public enum Result<V, E: Error> {
    case success(V)
    case failure(E)
}
