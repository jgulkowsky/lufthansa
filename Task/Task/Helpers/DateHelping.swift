//
//  DateHelping.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

protocol DateHelping: AnyObject {
    func dateToString(_ date: Date) -> String
    func dateFromString(_ string: String) -> Date?
    func setDateFormat(_ dateFormat: String)
}
