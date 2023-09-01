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

// MARK: didSet name tests

extension RegisterViewModelTests {
    func test_given_nameErrorIsSet_when_nameDidSetWithEmptyString_then_nameValidatorMethodIsNotCalled_andErrorVanishes() {
        // given
        viewModel.nameError = "some error"
        
        // when
        viewModel.name = ""
        
        // then
        XCTAssertFalse(nameValidator.hasValidated)
        XCTAssertNil(viewModel.nameError)
    }
    
    func test_given_nameErrorIsSet_andNameValidatorDoesntThrowError_when_nameDidSetWithNonEmptyString_then_nameValidatorMethodIsCalled_andErrorVanishes() {
        // given
        viewModel.nameError = "some error"
        nameValidator.shouldThrow = false
        
        // when
        viewModel.name = "some name"
        
        // then
        XCTAssertTrue(nameValidator.hasValidated)
        XCTAssertNil(viewModel.nameError)
    }
    
    func test_given_nameErrorIsSet_andNameValidatorThrowsError_when_nameDidSetWithNonEmptyString_then_nameValidatorMethodIsCalled_andErrorIsStillShown() {
        // given
        viewModel.nameError = "some error"
        nameValidator.shouldThrow = true
        
        // when
        viewModel.name = "some name"
        
        // then
        XCTAssertTrue(nameValidator.hasValidated)
        XCTAssertNotNil(viewModel.nameError)
    }
    
    func test_given_nameErrorIsNil_when_nameDidSetWithNonEmptyString_then_nameValidatorMethodIsNotCalled_andErrorIsStillNil() {
        // given
        viewModel.nameError = nil
        
        // when
        viewModel.name = "some name"
        
        // then
        XCTAssertFalse(nameValidator.hasValidated)
        XCTAssertNil(viewModel.nameError)
    }
}

// MARK: didSet email tests

extension RegisterViewModelTests {
    func test_given_emailErrorIsSet_when_emailDidSetWithEmptyString_then_emailValidatorMethodIsNotCalled_andErrorVanishes() {
        // given
        viewModel.emailError = "some error"
        
        // when
        viewModel.email = ""
        
        // then
        XCTAssertFalse(emailValidator.hasValidated)
        XCTAssertNil(viewModel.emailError)
    }
    
    func test_given_emailErrorIsSet_andEmailValidatorDoesntThrowError_when_emailDidSetWithNonEmptyString_then_emailValidatorMethodIsCalled_andErrorVanishes() {
        // given
        viewModel.emailError = "some error"
        emailValidator.shouldThrow = false
        
        // when
        viewModel.email = "some email"
        
        // then
        XCTAssertTrue(emailValidator.hasValidated)
        XCTAssertNil(viewModel.emailError)
    }
    
    func test_given_emailErrorIsSet_andEmailValidatorThrowsError_when_emailDidSetWithNonEmptyString_then_emailValidatorMethodIsCalled_andErrorIsStillShown() {
        // given
        viewModel.emailError = "some error"
        emailValidator.shouldThrow = true
        
        // when
        viewModel.email = "some email"
        
        // then
        XCTAssertTrue(emailValidator.hasValidated)
        XCTAssertNotNil(viewModel.emailError)
    }
    
    func test_given_emailErrorIsNil_when_emailDidSetWithNonEmptyString_then_emailValidatorMethodIsNotCalled_andErrorIsStillNil() {
        // given
        viewModel.emailError = nil
        
        // when
        viewModel.email = "some email"
        
        // then
        XCTAssertFalse(emailValidator.hasValidated)
        XCTAssertNil(viewModel.emailError)
    }
}

// MARK: didSet dateOfBirth tests

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

// MARK: errorToShow tests

extension RegisterViewModelTests {
    func test_given_allErrorsAreNil_when_errorToShowIsGet_then_nilIsReturned() {
        // given
        resetErrors()
        
        // when & then
        XCTAssertNil(viewModel.errorToShow)
    }
    
    func test_given_nameErrorIsSet_whileOtherAreNil_when_errorToShowIsGet_then_nameErrorIsReturned() {
        // given
        resetErrors()
        viewModel.nameError = "name error"
        
        // when & then
        XCTAssertEqual(viewModel.errorToShow, viewModel.nameError)
    }
    
    func test_given_emailErrorIsSet_whileOtherAreNil_when_errorToShowIsGet_then_emailErrorIsReturned() {
        // given
        resetErrors()
        viewModel.emailError = "email error"
        
        // when & then
        XCTAssertEqual(viewModel.errorToShow, viewModel.emailError)
    }
    
    func test_given_dateOfBirthErrorIsSet_whileOtherAreNil_when_errorToShowIsGet_then_dateOfBirthErrorIsReturned() {
        // given
        resetErrors()
        viewModel.dateOfBirthError = "dateOfBirth error"
        
        // when & then
        XCTAssertEqual(viewModel.errorToShow, viewModel.dateOfBirthError)
    }
    
    func test_given_allThreeErrorsAreSet_when_errorToShowIsGet_then_nameErrorIsReturned() {
        // given
        resetErrors()
        viewModel.nameError = "name error"
        viewModel.emailError = "email error"
        viewModel.dateOfBirthError = "dateOfBirth error"
        
        // when & then
        XCTAssertEqual(viewModel.errorToShow, viewModel.nameError)
    }
    
    func test_given_onlyEmailError_andDateOfBirthErrorAreSet_when_errorToShowIsGet_then_emailErrorIsReturned() {
        // given
        resetErrors()
        viewModel.emailError = "email error"
        viewModel.dateOfBirthError = "dateOfBirth error"
        
        // when & then
        XCTAssertEqual(viewModel.errorToShow, viewModel.emailError)
    }
    
    func test_given_onlyNameError_andEmailErrorAreSet_when_errorToShowIsGet_then_nameErrorIsReturned() {
        // given
        resetErrors()
        viewModel.nameError = "name error"
        viewModel.emailError = "email error"
        
        // when & then
        XCTAssertEqual(viewModel.errorToShow, viewModel.nameError)
    }
    
    func test_given_onlyNameError_andDateOfBirthErrorAreSet_when_errorToShowIsGet_then_nameErrorIsReturned() {
        // given
        resetErrors()
        viewModel.nameError = "name error"
        viewModel.dateOfBirthError = "dateOfBirth error"
        
        // when & then
        XCTAssertEqual(viewModel.errorToShow, viewModel.nameError)
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
    
    func test_given_nameIsNotEmpty_andEmailIsNotEmpty_andThereIsNoError_butSomeValidatorThrowsError_then_registerButtonIsDisabled() {
        // given
        given_nameIsNotEmpty_andEmailIsNotEmpty_andThereIsNoError()
        setRandomValidatorThrowing()
        
        // then
        XCTAssertFalse(viewModel.registerButtonEnabled)
    }
    
    private func given_nameIsNotEmpty_andEmailIsNotEmpty_andThereIsNoError() {
        viewModel.name = "some name"
        viewModel.email = "some email"
        resetErrors()
    }
    
    private func setRandomValidatorThrowing() {
        switch Int.random(in: 0..<3) {
        case 0: nameValidator.shouldThrow = true
        case 1: emailValidator.shouldThrow = true
        case 2: dateOfBirthValidator.shouldThrow = true
        default: break
        }
    }
}

// MARK: registerButtonColor tests

extension RegisterViewModelTests {
    func test_given_thereIsSomeError_then_registerButtonColorIsRed() {
        // given
        setRandomError()
        
        // then
        XCTAssertEqual(viewModel.registerButtonColor, .red)
    }
    
    func test_given_thereIsNoError_andRegisterButtonIsEnabled_then_registerButtonColorIsGreen() {
        // given
        resetErrors()
        enableRegisterButton()
        
        // then
        XCTAssertEqual(viewModel.registerButtonColor, .green)
    }
    
    func test_given_thereIsNoError_andRegisterButtonIsDisabled_then_registerButtonColorIsGray() {
        // given
        resetErrors()
        disableRegisterButton()
        
        // then
        XCTAssertEqual(viewModel.registerButtonColor, .gray)
    }
    
    private func enableRegisterButton() {
        viewModel.name = "some name"
        viewModel.email = "some email"
        resetErrors()
    }
    
    private func disableRegisterButton() {
        viewModel.name = ""
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

// MARK: - common code

private extension RegisterViewModelTests {
    func resetErrors() {
        viewModel.nameError = nil
        viewModel.emailError = nil
        viewModel.dateOfBirthError = nil
    }
    
    func setRandomError() {
        switch Int.random(in: 0..<3) {
        case 0: viewModel.nameError = "some error"
        case 1: viewModel.emailError = "some error"
        case 2: viewModel.dateOfBirthError = "some error"
        default: break
        }
    }
}
