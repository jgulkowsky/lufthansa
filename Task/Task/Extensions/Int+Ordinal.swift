//
//  Int+OrderedEnding.swift
//  Task
//
//  Created by Jan Gulkowski on 12/09/2023.
//

import Foundation

// todo: add tests for this extension

extension Int {
    var ordinal: String {
        var suffix: String
        let ones: Int = self % 10
        let tens: Int = (self / 10) % 10
        if tens == 1 {
            suffix = "th"
        } else if ones == 1 {
            suffix = "st"
        } else if ones == 2 {
            suffix = "nd"
        } else if ones == 3 {
            suffix = "rd"
        } else {
            suffix = "th"
        }
        return "\(self)\(suffix)"
    }
}
