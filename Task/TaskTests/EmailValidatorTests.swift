//
//  EmailValidatorTests.swift
//  EmailValidatorTests
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import XCTest
@testable import Task

final class EmailValidatorTests: XCTestCase {
    private var emailValidator: EmailValidator!
    
    override func setUp() {
        emailValidator = EmailValidator()
    }
    
    func test_given_emailWithoutPartBeforeAtSymbol_when_emailValidatorValidates_then_errorIsThrown() {
        assertErrorIsThrown(forEmail: "@some.proper.domain.co")
    }
    
    func test_given_emailWithoutPartAfterAtSymbol_when_emailValidatorValidates_then_errorIsThrown() {
        assertErrorIsThrown(forEmail: "some.something@")
    }
    
    func test_given_emailWithoutAtSymbol_when_emailValidatorValidates_then_errorIsThrown() {
        assertErrorIsThrown(forEmail: "no.at.symbol.unfortunatelly")
    }
    
    func test_given_emailWithDomainPartSmallerThan4Chars_when_emailValidatorValidates_then_errorIsThrown() {
        assertErrorIsThrown(forEmail: "this.is.ok@x.x")
    }
    
    func test_given_emailWithDomainPartWithoutDot_when_emailValidatorValidates_then_errorIsThrown() {
        assertErrorIsThrown(forEmail: "this.is.ok@but-this-dont-have-the-dot")
    }
    
    func test_given_emailWithDomainPartWithDifferentNumberOfCharsAfterTheDotThan2_when_emailValidatorValidates_then_errorIsThrown() {
        assertErrorIsThrown(forEmail: "this.is.ok@this-is-ok-too-but-after-the-last-dot.we.have.too.many.characters")
    }
    
    func test_given_validEmail_when_emailValidatorValidates_then_noErrorIsThrown() {
        do {
            try emailValidator.validate("THIS-is.VALID_email+0123456789._%+-@some-domain.name.co")
            XCTAssert(true)
        } catch {
            XCTFail("Validator should not throw any error")
        }
    }
}

private extension EmailValidatorTests {
    func assertErrorIsThrown(forEmail email: String) {
        do {
            try emailValidator.validate(email)
            XCTFail("Validator should throw error")
        } catch ValidationError.invalidEmail(_) {
            XCTAssert(true)
        } catch {
            XCTFail("Validator should throw error of type ValidationError.invalidEmail")
        }
    }
}
