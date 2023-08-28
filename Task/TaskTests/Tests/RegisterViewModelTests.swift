//
//  RegisterViewModelTests.swift
//  TaskTests
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import XCTest

final class RegisterViewModelTests: XCTestCase {
    private var viewModel: RegisterViewModel!
    
    private var coordinator: MockCoordinator!
    private var nameValidator: MockNameValidator!
    private var emailValidator: MockEmailValidator!
    private var dateOfBirthValidator: MockDateOfBirthValidator!
    
    override func setUp() {
        coordinator = MockCoordinator()
        nameValidator = MockNameValidator()
        emailValidator = MockEmailValidator()
        dateOfBirthValidator = MockDateOfBirthValidator()
        
        viewModel = RegisterViewModel(
            coordinator: coordinator,
            nameValidator: nameValidator,
            emailValidator: emailValidator,
            dateOfBirthValidator: dateOfBirthValidator
        )
    }
    
    func test_given_validatorsDontThrowDuringValidation_when_viewModelOnRegisterButtonTapped_then_noErrorIsShownAndCoordinatorGoesToConfirmation() {
        // when
        viewModel.onRegisterButtonTapped()
        
        // then
        XCTAssertNil(viewModel.error)
        XCTAssertTrue(coordinator.wentToConfirmation)
    }
    
    func test_given_nameValidatorThrows_when_viewModelOnRegisterButtonTapped_then_coordinatorDoesntGoToConfirmationAndErrorIsShown() {
        // given
        nameValidator.shouldThrow = true
        
        // when
        viewModel.onRegisterButtonTapped()
        
        // then
        XCTAssertFalse(coordinator.wentToConfirmation)
        XCTAssertNotNil(viewModel.error)
    }
    
    func test_given_emailValidatorThrows_when_viewModelOnRegisterButtonTapped_then_coordinatorDoesntGoToConfirmationAndErrorIsShown() {
        // given
        emailValidator.shouldThrow = true
        
        // when
        viewModel.onRegisterButtonTapped()
        
        // then
        XCTAssertFalse(coordinator.wentToConfirmation)
        XCTAssertNotNil(viewModel.error)
    }
    
    func test_given_dateOfBirthValidatorThrows_when_viewModelOnRegisterButtonTapped_then_coordinatorDoesntGoToConfirmationAndErrorIsShown() {
        // given
        dateOfBirthValidator.shouldThrow = true
        
        // when
        viewModel.onRegisterButtonTapped()
        
        // then
        XCTAssertFalse(coordinator.wentToConfirmation)
        XCTAssertNotNil(viewModel.error)
    }
}
