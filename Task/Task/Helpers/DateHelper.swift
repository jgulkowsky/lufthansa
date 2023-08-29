//
//  DateHelper.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

class DateHelper: DateHelping {
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter
    }()
    
    func dateToString(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func dateFromString(_ string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
    
    func setDateFormat(_ dateFormat: String) {
        dateFormatter.dateFormat = dateFormat
    }
}
