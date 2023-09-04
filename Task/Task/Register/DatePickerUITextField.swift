//
//  DatePickerUITextField.swift
//  Task
//
//  Created by Jan Gulkowski on 04/09/2023.
//

import SwiftUI
import UIKit

final class DatePickerUITextField: UITextField {
    @Binding var date: Date?
    @Binding var color: UIColor
    private let datePicker = UIDatePicker()
    
    init(date: Binding<Date?>, color: Binding<UIColor>, frame: CGRect) {
        self._date = date
        self._color = color
        super.init(frame: frame)
        self.textAlignment = .right
        self.textColor = self.color
        inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerDidSelect(_:)), for: .valueChanged)
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func datePickerDidSelect(_ sender: UIDatePicker) {
        date = sender.date
        self.textColor = color
    }
    
    @objc private func dismissTextField() {
        resignFirstResponder()
    }
}
