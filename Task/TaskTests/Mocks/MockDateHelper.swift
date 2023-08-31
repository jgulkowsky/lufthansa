//
//  MockDateHelper.swift
//  TaskTests
//
//  Created by Jan Gulkowski on 31/08/2023.
//

import Foundation

class MockDateHelper: DateHelping {
    var stringToReturn = "10/04/2020"
    var datesToReturn: [Date] = []
    
    private var datesToReturnIndex = 0
    
    func dateToString(_ date: Date) -> String {
        return stringToReturn
    }
    
    func dateFromString(_ string: String) -> Date? {
        if datesToReturnIndex < datesToReturn.count {
            let dateToReturn =  datesToReturn[datesToReturnIndex]
            datesToReturnIndex += 1
            return dateToReturn
        }
        print("@jgu: Error in MockDateHelper.dateFromString - index is out of bounds! You need to set datesToReturn and their count should match number of calls to MockDateHelper.dateFromString!")
        return nil
    }
    
    func setDateFormat(_ dateFormat: String) {}
}
