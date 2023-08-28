//
//  DateHelper.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

struct DateHelper: DateHelping {
    func dateToString(_ date: Date, withFormat dateFormat: String) -> String {
        let dateFormatter = getDateFormatter(withFormat: dateFormat)
        return dateFormatter.string(from: date)
    }
    
    func dateFromString(_ string: String, withFormat dateFormat: String) -> Date? {
        let dateFormatter = getDateFormatter(withFormat: dateFormat)
        return dateFormatter.date(from: string)
    }
}

private extension DateHelper {
    func getDateFormatter(withFormat dateFormat: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter
    }
}
