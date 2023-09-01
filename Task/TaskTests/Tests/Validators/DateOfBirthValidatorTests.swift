//
//  DateOfBirthValidatorTests.swift
//  TaskTests
//
//  Created by Jan Gulkowski on 31/08/2023.
//

import XCTest

final class DateOfBirthValidatorTests: XCTestCase {
    private var dateOfBirthValidator: DateOfBirthValidator!
    private var dateHelper: MockDateHelper!
    
    override func setUp() {
        dateHelper = MockDateHelper()
        dateOfBirthValidator = DateOfBirthValidator(
            dateHelper: dateHelper
        )
    }
    
    func test_given_dateHelperReturns_minDateAs20thOfMarch2020_andMaxDateAs21stOfApril2021_when_dateOfBirthValidatorValidatesForDate_10thOfDecember2020_whichIsBetweenTheseTwoDates_then_noErrorIsThrowns() {
        // given
        given_dateHelperReturns_minDateAs20thOfMarch2020_andMaxDateAs21stOfApril2021()
        
        // when & then
        let date = Date(timeIntervalSince1970: 1607731200) // 10th of December 2020 00:00:00 gmt0
        when_dateOfBirthValidatorValidatesForDate(date, thenItShouldThrowError: false)
    }
    
    func test_given_dateHelperReturns_minDateAs20thOfMarch2020_andMaxDateAs21stOfApril2021_when_dateOfBirthValidatorValidatesForDate_10thOfDecember2019_whichIsBeforeFirstDate_then_errorIsThrown() {
        // given
        given_dateHelperReturns_minDateAs20thOfMarch2020_andMaxDateAs21stOfApril2021()
        
        // when & then
        let date = Date(timeIntervalSince1970: 1575936000) // 10th of December 2019 00:00:00 gmt0
        when_dateOfBirthValidatorValidatesForDate(date, thenItShouldThrowError: true)
    }
    
    func test_given_dateHelperReturns_minDateAs20thOfMarch2020_andMaxDateAs21stOfApril2021_when_dateOfBirthValidatorValidatesForDate_10thOfDecember2022_whichIsAfterSecondDate_then_errorIsThrown() {
        // given
        given_dateHelperReturns_minDateAs20thOfMarch2020_andMaxDateAs21stOfApril2021()
        
        // when & then
        let date = Date(timeIntervalSince1970: 1670630400) // 10th of December 2022 00:00:00 gmt0
        when_dateOfBirthValidatorValidatesForDate(date, thenItShouldThrowError: true)
    }
}

private extension DateOfBirthValidatorTests {
    func given_dateHelperReturns_minDateAs20thOfMarch2020_andMaxDateAs21stOfApril2021() {
        dateHelper.datesToReturn = [
            Date(timeIntervalSince1970: 1584662400), // 20th of March 2020 00:00:00 gmt0
            Date(timeIntervalSince1970: 1618963200)  // 21st of April 2021 00:00:00 gmt0
        ]
    }
    
    func when_dateOfBirthValidatorValidatesForDate(_ date: Date, thenItShouldThrowError shouldThrow: Bool) {
        do {
            try dateOfBirthValidator.validate(date)
            if shouldThrow {
                XCTFail("Validator should throw error")
            } else {
                XCTAssert(true)
            }
        } catch {
            if shouldThrow {
                XCTAssert(true)
            } else {
                XCTFail("Validator should not throw error")
            }
        }
    }
}
