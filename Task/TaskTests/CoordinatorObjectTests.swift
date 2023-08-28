//
//  CoordinatorObjectTests.swift
//  TaskTests
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import XCTest

final class CoordinatorObjectTests: XCTestCase {
    private var coordinatorObject: CoordinatorObject!
    
    override func setUp() {
        coordinatorObject = CoordinatorObject()
    }
    
    func test_when_coordinatorObjectIsInitialized_then_registerViewModelIsSetAndConfirmationViewModelIsNot() {
        // then
        XCTAssertNotNil(coordinatorObject.registerViewModel)
        XCTAssertNil(coordinatorObject.confirmationViewModel)
    }
    
    func test_when_coordinatorObjectGoesToConfirmation_then_bothRegisterViewModelAndConfirmationViewModelAreSet() {
        // when
        coordinatorObject.goToConfirmation(
            ConfirmationInfo(
                name: "some name",
                email: "some email",
                dateOfBirth: Date.now
            )
        )
        
        // then
        XCTAssertNotNil(coordinatorObject.registerViewModel)
        XCTAssertNotNil(coordinatorObject.confirmationViewModel)
    }
}
