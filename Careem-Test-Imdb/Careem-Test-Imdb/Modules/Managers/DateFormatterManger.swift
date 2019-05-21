//
//  DateFormatterManger.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 21/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation



class DateFormatterManger{
    
    static let releaseDateFormat = "yyyy-MM-dd"
    
    static let dateFormatterForReleaseDate = { () -> DateFormatter in
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = releaseDateFormat
        return formatter
    }()
    
}
