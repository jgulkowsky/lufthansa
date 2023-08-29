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
        XCTAssertEqual(date?.timeIntervalSince1970, DateHelperTests.timestampUno) // todo: problem with gmt zones - we are in Poland gmt+1 and date is given as for gmt+0 (what would be the correct approach to this? probably we should always have some time zone info in our DateHelper.dateFormatter)
    }
    
    // todo: add tests also for dateFromSting and changing dateFormat
}
