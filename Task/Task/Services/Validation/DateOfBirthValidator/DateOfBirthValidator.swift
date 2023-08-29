//
//  DateOfBirthValidator.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

struct DateOfBirthValidator: DateOfBirthValidating {
    private unowned var dateHelper: DateHelping
    
    private static let minDateString = "1/1/1900"
    private static let maxDateString = "31/12/2019"
    private static let dateFormat = "dd/MM/yy"
    
    private static let message = "Date of birth needs to be between \(minDateString) and \(maxDateString)"
    
    init(dateHelper: DateHelping) {
        self.dateHelper = dateHelper
    }
    
    func validate(_ dateOfBirth: Date) throws {
        if !isDateOfBirthValid(dateOfBirth) {
            throw ValidationError.invalidDateOfBirth(message: DateOfBirthValidator.message)
        }
    }
}

private extension DateOfBirthValidator {
    func isDateOfBirthValid(_ dateOfBirth: Date) -> Bool {
        dateHelper.setDateFormat(DateOfBirthValidator.dateFormat)
        let minDate = dateHelper.dateFromString(
            DateOfBirthValidator.minDateString
        )!
        let maxDate = dateHelper.dateFromString(
            DateOfBirthValidator.maxDateString
        )!
        return dateOfBirth >= minDate && dateOfBirth <= maxDate
    }
}
