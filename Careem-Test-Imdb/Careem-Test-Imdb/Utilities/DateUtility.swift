//
//  DateUtility.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 22/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation

struct DateUtility {
    
    static func convertShortToLong(from shortFormatDate: String?) -> String?  {
        
        guard let shortFormatDate = shortFormatDate else { return nil }
        guard let date = DateFormatter.shortFormatDateFormatter.date(from: shortFormatDate) else { return nil }
        return  DateFormatter.longFormatDateFormatter.string(from: date)
       
    }
}
