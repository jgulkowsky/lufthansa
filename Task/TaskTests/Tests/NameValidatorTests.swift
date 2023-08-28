//
//  NameValidatorTests.swift
//  TaskTests
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import XCTest

final class NameValidatorTests: XCTestCase {
    private var nameValidator: NameValidator!
    
    override func setUp() {
        nameValidator = NameValidator()
    }
    
    func test_given_emptyName_when_nameValidatorValidates_then_errorIsThrown() {
        do {
            try nameValidator.validate("")
            XCTFail("Validator should throw error")
        } catch ValidationError.invalidName(_) {
            XCTAssert(true)
        } catch {
            XCTFail("Validator should throw error of type ValidationError.invalidName")
        }
    }
    
    func test_given_nonEmptyNameButConsistingOfASpace_when_nameValidatorValidates_then_errorIsThrown() {
        do {
            try nameValidator.validate("    ")
            XCTFail("Validator should throw error")
        } catch ValidationError.invalidName(_) {
            XCTAssert(true)
        } catch {
            XCTFail("Validator should throw error of type ValidationError.invalidName")
        }
    }
    
    func test_given_nonEmptyName_when_nameValidatorValidates_then_noErrorIsThrown() {
        do {
            try nameValidator.validate("X")
            XCTAssert(true)
        } catch {
            XCTFail("Validator should throw no error")
        }
    }
}
