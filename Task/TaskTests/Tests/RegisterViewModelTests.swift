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
        viewModel.latestError = "some error"
        
        // then
        XCTAssertFalse(viewModel.registerButtonEnabled)
    }
    
    private func given_nameIsNotEmpty_andEmailIsNotEmpty_andThereIsNoError() {
        viewModel.name = "some name"
        viewModel.email = "some email"
        viewModel.latestError = nil
    }
}

// MARK: onFinishedEditingName & onStartedEditingName tests

extension RegisterViewModelTests {
    func test_given_nameValidatorThrowsError_andNameIsNotEmpty_andThereIsNoError_when_onFinishedEditingNameCalled_then_errorIsSet() {
        // given
        nameValidator.shouldThrow = true
        viewModel.name = "some name"
        viewModel.latestError = nil
        
        // when
        viewModel.onFinishedEditingName()
        
        // then
        XCTAssertNotNil(viewModel.latestError)
    }
    
    func test_given_nameValidatorThrowsError_andNameIsEmpty_andThereIsNoError_when_onFinishedEditingNameCalled_then_thereIsStillNoError() {
        // given
        nameValidator.shouldThrow = true
        viewModel.name = ""
        viewModel.latestError = nil
        
        // when
        viewModel.onFinishedEditingName()
        
        // then
        XCTAssertNil(viewModel.latestError)
    }
    
    func test_given_nameValidatorDoesntThrowError_andNameIsNotEmpty_andThereIsNoError_when_onFinishedEditingNameCalled_then_thereIsStillNoError() {
        // given
        nameValidator.shouldThrow = false
        viewModel.name = "some name"
        viewModel.latestError = nil
        
        // when
        viewModel.onFinishedEditingName()
        
        // then
        XCTAssertNil(viewModel.latestError)
    }
    
    func test_given_errorWasSetOnCallToFinishedEditingName_when_onStartedEditingNameIsCalled_then_errorVanishes() {
        // given
        nameValidator.shouldThrow = true
        viewModel.name = "some name"
        viewModel.onFinishedEditingName()
        guard viewModel.latestError != nil else {
            XCTFail("Error should be set during onFinishedEditingName")
            return
        }
        
        // when
        viewModel.onStartedEditingName()
        
        // then
        XCTAssertNil(viewModel.latestError)
    }
}

// MARK: onFinishedEditingEmail & onStartedEditingEmail tests

extension RegisterViewModelTests {
    func test_given_emailValidatorThrowsError_andEmailIsNotEmpty_andThereIsNoError_when_onFinishedEditingEmailCalled_then_errorIsSet() {
        // given
        emailValidator.shouldThrow = true
        viewModel.email = "some email"
        viewModel.latestError = nil
        
        // when
        viewModel.onFinishedEditingEmail()
        
        // then
        XCTAssertNotNil(viewModel.latestError)
    }
    
    func test_given_emailValidatorThrowsError_andEmailIsEmpty_andThereIsNoError_when_onFinishedEditingEmailCalled_then_thereIsStillNoError() {
        // given
        emailValidator.shouldThrow = true
        viewModel.email = ""
        viewModel.latestError = nil
        
        // when
        viewModel.onFinishedEditingEmail()
        
        // then
        XCTAssertNil(viewModel.latestError)
    }
    
    func test_given_emailValidatorDoesntThrowError_andEmailIsNotEmpty_andThereIsNoError_when_onFinishedEditingEmailCalled_then_thereIsStillNoError() {
        // given
        emailValidator.shouldThrow = false
        viewModel.email = "some email"
        viewModel.latestError = nil
        
        // when
        viewModel.onFinishedEditingEmail()
        
        // then
        XCTAssertNil(viewModel.latestError)
    }
    
    func test_given_errorWasSetOnCallToFinishedEditingEmail_when_onStartedEditingEmailIsCalled_then_errorVanishes() {
        // given
        emailValidator.shouldThrow = true
        viewModel.email = "some email"
        viewModel.onFinishedEditingEmail()
        guard viewModel.latestError != nil else {
            XCTFail("Error should be set during onFinishedEditingEmail")
            return
        }
        
        // when
        viewModel.onStartedEditingEmail()
        
        // then
        XCTAssertNil(viewModel.latestError)
    }
}

// MARK: on dateOfBirth didSet tests

extension RegisterViewModelTests {
    func test_given_dateOfBirthValidatorThrowsError_andThereIsNoError_when_dateOfBirthIsSet_then_errorIsSet() {
        // given
        dateOfBirthValidator.shouldThrow = true
        viewModel.latestError = nil
        
        // when
        viewModel.dateOfBirth = Date.now
        
        // then
        XCTAssertNotNil(viewModel.latestError)
    }
    
    func test_given_dateOfBirthValidatorDoesntThrowError_andThereIsNoError_when_dateOfBirthIsSet_then_thereIsStillNoError() {
        // given
        dateOfBirthValidator.shouldThrow = false
        viewModel.latestError = nil
        
        // when
        viewModel.dateOfBirth = Date.now
        
        // then
        XCTAssertNil(viewModel.latestError)
    }
}

// MARK: one error should be replaced with next one

extension RegisterViewModelTests {
    func test_given_errorIsRelatedToName_when_newErrorIsShownThatIsRelatedToEmail_then_emailErrorIsVisible() {
        // given
        nameValidator.shouldThrow = true
        nameValidator.messageToThrow = "name error"
        viewModel.name = "some name"
        viewModel.onFinishedEditingName()
        guard viewModel.latestError != nil else {
            XCTFail("Error should be set during onFinishedEditingName")
            return
        }
        
        // when
        emailValidator.shouldThrow = true
        emailValidator.messageToThrow = "email error"
        viewModel.email = "some mail"
        viewModel.onFinishedEditingEmail()
        
        // then
        XCTAssertNotNil(viewModel.latestError)
        XCTAssertEqual(viewModel.latestError, emailValidator.messageToThrow)
    }
}

// MARK: previous error should show up when the one covering him is fixed

extension RegisterViewModelTests {
    func test_given_errorWasShownRelatedToName_thenItWasCoveredWithErrorRelatedToEmail_when_errorRelatedToEmailVanishes_then_errorRelatedToNameShoulStillBePresent() {
        // todo: I believe we don't have this functionality yet
    }
}

// MARK: - onRegisterButtonTapped tests

extension RegisterViewModelTests {
    func test_given_validatorsDontThrowDuringValidation_when_viewModelOnRegisterButtonTapped_then_noErrorIsShown_hapticFeedbackGeneratorIsAskedToGenerateSuccessfulSound_andCoordinatorGoesToConfirmation() {
        // when
        viewModel.onRegisterButtonTapped()
        
        // then
        XCTAssertNil(viewModel.latestError)
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
        XCTAssertNotNil(viewModel.latestError)
        XCTAssertFalse(hapticFeedbackGenerator.generatedSuccessfulSound)
    }
    
    func test_given_emailValidatorThrows_when_viewModelOnRegisterButtonTapped_then_coordinatorDoesntGoToConfirmation_andErrorIsShown_andHapticFeedbackGeneratorIsNotAskedToGenerateSuccessfulSound() {
        // given
        emailValidator.shouldThrow = true
        
        // when
        viewModel.onRegisterButtonTapped()
        
        // then
        XCTAssertFalse(coordinator.wentToConfirmation)
        XCTAssertNotNil(viewModel.latestError)
        XCTAssertFalse(hapticFeedbackGenerator.generatedSuccessfulSound)
    }
    
    func test_given_dateOfBirthValidatorThrows_when_viewModelOnRegisterButtonTapped_then_coordinatorDoesntGoToConfirmation_andErrorIsShown_andHapticFeedbackGeneratorIsNotAskedToGenerateSuccessfulSound() {
        // given
        dateOfBirthValidator.shouldThrow = true
        
        // when
        viewModel.onRegisterButtonTapped()
        
        // then
        XCTAssertFalse(coordinator.wentToConfirmation)
        XCTAssertNotNil(viewModel.latestError)
        XCTAssertFalse(hapticFeedbackGenerator.generatedSuccessfulSound)
    }
}
