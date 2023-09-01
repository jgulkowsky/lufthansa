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
    private var hapticFeedbackGenerator: MockHapticFeedbackGenerator!
    
    override func setUp() {
        coordinator = MockCoordinator()
        nameValidator = MockNameValidator()
        emailValidator = MockEmailValidator()
        dateOfBirthValidator = MockDateOfBirthValidator()
        hapticFeedbackGenerator = MockHapticFeedbackGenerator()
        
        viewModel = RegisterViewModel(
            coordinator: coordinator,
            nameValidator: nameValidator,
            emailValidator: emailValidator,
            dateOfBirthValidator: dateOfBirthValidator,
            hapticFeedbackGenerator: hapticFeedbackGenerator
        )
    }
}

// MARK: registerButtonEnabled tests

extension RegisterViewModelTests {
    func test_given_nameIsNotEmpty_andEmailIsNotEmpty_andThereIsNoError_then_registerButtonIsEnabled() {
        // given
        given_nameIsNotEmpty_andEmailIsNotEmpty_andThereIsNoError()
        
        // then
        XCTAssertTrue(viewModel.registerButtonEnabled)
    }
    
    func test_given_nameIsNotEmpty_andEmailIsNotEmpty_andThereIsNoError_when_nameBecomesEmpty_then_registerButtonIsDisabled() {
        // given
        given_nameIsNotEmpty_andEmailIsNotEmpty_andThereIsNoError()
        
        // when
        viewModel.name = ""
        
        // then
        XCTAssertFalse(viewModel.registerButtonEnabled)
    }
    
    func test_given_nameIsNotEmpty_andEmailIsNotEmpty_andThereIsNoError_when_emailBecomesEmpty_then_registerButtonIsDisabled() {
        // given
        given_nameIsNotEmpty_andEmailIsNotEmpty_andThereIsNoError()
        
        // when
        viewModel.email = ""
        
        // then
        XCTAssertFalse(viewModel.registerButtonEnabled)
    }
    
    func test_given_nameIsNotEmpty_andEmailIsNotEmpty_andThereIsNoError_when_errorIsSet_then_registerButtonIsDisabled() {
        // given
        given_nameIsNotEmpty_andEmailIsNotEmpty_andThereIsNoError()
        
        // when
        setRandomError()
        
        // then
        XCTAssertFalse(viewModel.registerButtonEnabled)
    }
    
    private func given_nameIsNotEmpty_andEmailIsNotEmpty_andThereIsNoError() {
        viewModel.name = "some name"
        viewModel.email = "some email"
        resetErrors()
    }
    
    private func setRandomError() {
        switch Int.random(in: 0..<3) {
        case 0: viewModel.nameError = "some error"
        case 1: viewModel.emailError = "some error"
        case 2: viewModel.dateOfBirthError = "some error"
        default: break
        }
    }
}

// MARK: onFinishedEditingName tests

extension RegisterViewModelTests {
    func test_given_nameValidatorThrowsError_andNameIsNotEmpty_andThereIsNoError_when_onFinishedEditingNameCalled_then_errorIsSet() {
        // given
        nameValidator.shouldThrow = true
        viewModel.name = "some name"
        resetErrors()
        
        // when
        viewModel.onFinishedEditingName()
        
        // then
        XCTAssertNotNil(viewModel.errorToShow)
    }
    
    func test_given_nameValidatorThrowsError_andNameIsEmpty_andThereIsNoError_when_onFinishedEditingNameCalled_then_thereIsStillNoError() {
        // given
        nameValidator.shouldThrow = true
        viewModel.name = ""
        resetErrors()
        
        // when
        viewModel.onFinishedEditingName()
        
        // then
        XCTAssertNil(viewModel.errorToShow)
    }
    
    func test_given_nameValidatorDoesntThrowError_andNameIsNotEmpty_andThereIsNoError_when_onFinishedEditingNameCalled_then_thereIsStillNoError() {
        // given
        nameValidator.shouldThrow = false
        viewModel.name = "some name"
        resetErrors()
        
        // when
        viewModel.onFinishedEditingName()
        
        // then
        XCTAssertNil(viewModel.errorToShow)
    }
}

// MARK: onFinishedEditingEmail tests

extension RegisterViewModelTests {
    func test_given_emailValidatorThrowsError_andEmailIsNotEmpty_andThereIsNoError_when_onFinishedEditingEmailCalled_then_errorIsSet() {
        // given
        emailValidator.shouldThrow = true
        viewModel.email = "some email"
        resetErrors()
        
        // when
        viewModel.onFinishedEditingEmail()
        
        // then
        XCTAssertNotNil(viewModel.errorToShow)
    }
    
    func test_given_emailValidatorThrowsError_andEmailIsEmpty_andThereIsNoError_when_onFinishedEditingEmailCalled_then_thereIsStillNoError() {
        // given
        emailValidator.shouldThrow = true
        viewModel.email = ""
        resetErrors()
        
        // when
        viewModel.onFinishedEditingEmail()
        
        // then
        XCTAssertNil(viewModel.errorToShow)
    }
    
    func test_given_emailValidatorDoesntThrowError_andEmailIsNotEmpty_andThereIsNoError_when_onFinishedEditingEmailCalled_then_thereIsStillNoError() {
        // given
        emailValidator.shouldThrow = false
        viewModel.email = "some email"
        resetErrors()
        
        // when
        viewModel.onFinishedEditingEmail()
        
        // then
        XCTAssertNil(viewModel.errorToShow)
    }
}

// MARK: on dateOfBirth didSet tests

extension RegisterViewModelTests {
    func test_given_dateOfBirthValidatorThrowsError_andThereIsNoError_when_dateOfBirthIsSet_then_errorIsSet() {
        // given
        dateOfBirthValidator.shouldThrow = true
        resetErrors()
        
        // when
        viewModel.dateOfBirth = Date.now
        
        // then
        XCTAssertNotNil(viewModel.errorToShow)
    }
    
    func test_given_dateOfBirthValidatorDoesntThrowError_andThereIsNoError_when_dateOfBirthIsSet_then_thereIsStillNoError() {
        // given
        dateOfBirthValidator.shouldThrow = false
        resetErrors()
        
        // when
        viewModel.dateOfBirth = Date.now
        
        // then
        XCTAssertNil(viewModel.errorToShow)
    }
}

// MARK: - onRegisterButtonTapped tests

extension RegisterViewModelTests {
    func test_given_validatorsDontThrowDuringValidation_when_viewModelOnRegisterButtonTapped_then_noErrorIsShown_hapticFeedbackGeneratorIsAskedToGenerateSuccessfulSound_andCoordinatorGoesToConfirmation() {
        // when
        viewModel.onRegisterButtonTapped()
        
        // then
        XCTAssertNil(viewModel.errorToShow)
        XCTAssertTrue(coordinator.wentToConfirmation)
        XCTAssertTrue(hapticFeedbackGenerator.generatedSuccessfulSound)
    }
    
    func test_given_nameValidatorThrows_when_viewModelOnRegisterButtonTapped_then_coordinatorDoesntGoToConfirmation_andErrorIsShown_andHapticFeedbackGeneratorIsNotAskedToGenerateSuccessfulSound() {
        // given
        nameValidator.shouldThrow = true
        
        // when
        viewModel.onRegisterButtonTapped()
        
        // then
        XCTAssertFalse(coordinator.wentToConfirmation)
        XCTAssertNotNil(viewModel.errorToShow)
        XCTAssertFalse(hapticFeedbackGenerator.generatedSuccessfulSound)
    }
    
    func test_given_emailValidatorThrows_when_viewModelOnRegisterButtonTapped_then_coordinatorDoesntGoToConfirmation_andErrorIsShown_andHapticFeedbackGeneratorIsNotAskedToGenerateSuccessfulSound() {
        // given
        emailValidator.shouldThrow = true
        
        // when
        viewModel.onRegisterButtonTapped()
        
        // then
        XCTAssertFalse(coordinator.wentToConfirmation)
        XCTAssertNotNil(viewModel.errorToShow)
        XCTAssertFalse(hapticFeedbackGenerator.generatedSuccessfulSound)
    }
    
    func test_given_dateOfBirthValidatorThrows_when_viewModelOnRegisterButtonTapped_then_coordinatorDoesntGoToConfirmation_andErrorIsShown_andHapticFeedbackGeneratorIsNotAskedToGenerateSuccessfulSound() {
        // given
        dateOfBirthValidator.shouldThrow = true
        
        // when
        viewModel.onRegisterButtonTapped()
        
        // then
        XCTAssertFalse(coordinator.wentToConfirmation)
        XCTAssertNotNil(viewModel.errorToShow)
        XCTAssertFalse(hapticFeedbackGenerator.generatedSuccessfulSound)
    }
}

private extension RegisterViewModelTests {
    func resetErrors() {
        viewModel.nameError = nil
        viewModel.emailError = nil
        viewModel.dateOfBirthError = nil
    }
}
