//
//  DateHelperTests.swift
//  TaskTests
//
//  Created by Jan Gulkowski on 29/08/2023.
//

import XCTest

final class DateHelperTests: XCTestCase {
    private static let timestampUno: TimeInterval = 1583798400 // 10 March 2020 00:00 GMT
    private static let timestampDos: TimeInterval = 1583107200 // 2 March 2020 00:00 GMT
    
    private var dateHelper: DateHelper!
    
    override func setUp() {
        dateHelper = DateHelper()
    }
}

// MARK: - dateToString tests

extension DateHelperTests {
    
    func test_given_dateIs_10_March_2020_andDateFormatIsDefault_when_dateToString_then_10_mar_2020_shouldBeReturned() {
        // given
        let date = Date(timeIntervalSince1970: DateHelperTests.timestampUno)
        
        // when
        let string = dateHelper.dateToString(date)
        
        // then
        XCTAssertEqual(string, "10 mar 2020")
    }
    
    func test_given_dateIs_2_March_2020_andDateFormatIsDefault_when_dateToString_then_02_mar_2020_shouldBeReturned() {
        // given
        let date = Date(timeIntervalSince1970: DateHelperTests.timestampDos)
        
        // when
        let string = dateHelper.dateToString(date)
        
        // then
        XCTAssertEqual(string, "02 mar 2020")
    }
    
    func test_given_dateIs_10_March_2020_andDateFormatIsddSlashMMSlashyy_when_dateToString_then_10Slash03Slash20_shouldBeReturned() {
        // given
        let date = Date(timeIntervalSince1970: DateHelperTests.timestampUno)
        dateHelper.setDateFormat("dd/MM/yy")
        
        // when
        let string = dateHelper.dateToString(date)
        
        // then
        XCTAssertEqual(string, "10/03/20")
    }
    
    func test_given_dateIs_10_March_2020_andDateFormatIsddSlashMMSlashyyyy_when_dateToString_then_10Slash03Slash2020_shouldBeReturned() {
        // given
        let date = Date(timeIntervalSince1970: DateHelperTests.timestampUno)
        dateHelper.setDateFormat("dd/MM/yyyy")
        
        // when
        let string = dateHelper.dateToString(date)
        
        // then
        XCTAssertEqual(string, "10/03/2020")
    }
}

// MARK: - dateFromString tests

extension DateHelperTests {
    func test_given_StringIs_10_March_2020_andDateFormatIsDefault_when_dateFromString_then_nilShouldBeReturned() {
        // given
        let string = "10 March 2020"
        
        // when
        let date = dateHelper.dateFromString(string)
        
        // then
        XCTAssertNil(date)
    }
    
    func test_given_StringIs_10_mar_2020_andDateFormatIsDefault_when_dateFromString_then_1583798400ShouldBeReturned() {
        // given
        let string = "10 mar 2020"
        
        // when
        let date = dateHelper.dateFromString(string)
        
        // then
        XCTAssertNotNil(date)
        XCTAssertEqual(date?.timeIntervalSince1970, DateHelperTests.timestampUno)
    }
    
    // todo: for some reason when I set dateFormat to be sth else than the default on dd MMM yyyy and pass let's say 10 mar 2020 (that's in previous format) then I can still get proper date - that's weird and we should check it out later on and write tests related to this
}
