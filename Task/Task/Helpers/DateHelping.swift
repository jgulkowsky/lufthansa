//
//  DateHelping.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

protocol DateHelping {
    func dateToString(_ date: Date, withFormat dateFormat: String) -> String
    func dateFromString(_ string: String, withFormat dateFormat: String) -> Date?
}
