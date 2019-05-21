//
//  DatePicketView.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 21/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import UIKit

protocol DatePickerViewDelegate: class {
    
    func datePickerDidCancel(_ sender: DatePickerView)
    func datePicker(_ sender: DatePickerView, didSelect date: Date)
}

class DatePickerView: UIView {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    weak var delegate: DatePickerViewDelegate?
    
    @IBAction func onTapDoneButton(_ sender: Any) {
        delegate?.datePicker(self, didSelect: datePicker.date)
    }
    
    @IBAction func onTapCancelButton(_ sender: Any) {
        delegate?.datePickerDidCancel(self)
    }
}
