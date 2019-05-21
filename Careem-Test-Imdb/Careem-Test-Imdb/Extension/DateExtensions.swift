//
//  DateExtensions.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 21/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import UIKit


extension Date {
    func stringValue(formatter: DateFormatter) -> String? {
        return formatter.string(from: self)
    }
}
