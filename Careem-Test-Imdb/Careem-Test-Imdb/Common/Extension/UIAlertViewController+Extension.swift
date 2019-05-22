//
//  UIAlertViewController+Extension.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 22/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import UIKit


extension UIAlertController {
    
    static func popAlert(withMessage  message: String) {
        
        let controller = UIAlertController(title: "Error Message",
                                           message: message,
                                           preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        controller.addAction(action)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
    }
}
