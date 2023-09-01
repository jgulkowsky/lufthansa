//
//  RegisterViewModel.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var name: String = "" {
        didSet {
            if nameError != nil {
                validateNameIfNotEmpty()
            }
        }
    }
    
    @Published var email: String = "" {
        didSet {
            if emailError != nil {
                validateEmailIfNotEmpty()
            }
        }
    }
    
    @Published var dateOfBirth: Date = Date(timeIntervalSince1970: 946724400) {
        didSet {
            onSetNewDateOfBirth()
        }
    }
    
    var errorToShow: String? {
        [nameError, emailError, dateOfBirthError]
        .compactMap { $0 }
        .first
    }
    
    @Published var nameError: String? = nil
    @Published var emailError: String? = nil
    @Published var dateOfBirthError: String? = nil
    
    var registerButtonEnabled: Bool {
        !name.isEmpty && !email.isEmpty && errorToShow == nil
    }
    
    private unowned var coordinator: Coordinator
    
    private var nameValidator: NameValidating
    private var emailValidator: EmailValidating
    private var dateOfBirthValidator: DateOfBirthValidating
    private var hapticFeedbackGenerator: HapticFeedbackGenerating
    
    init(coordinator: Coordinator,
         nameValidator: NameValidating,
         emailValidator: EmailValidating,
         dateOfBirthValidator: DateOfBirthValidating,
         hapticFeedbackGenerator: HapticFeedbackGenerating) {
        self.coordinator = coordinator
        self.nameValidator = nameValidator
        self.emailValidator = emailValidator
        self.dateOfBirthValidator = dateOfBirthValidator
        self.hapticFeedbackGenerator = hapticFeedbackGenerator
    }
    
    func onFinishedEditingName() {
        validateNameIfNotEmpty()
    }
    
    func onFinishedEditingEmail() {
        validateEmailIfNotEmpty()
    }
    
    func onRegisterButtonTapped() {
        validateFields()
        
        guard errorToShow == nil else {
            return
        }
        
        hapticFeedbackGenerator.generateSuccessSound()
        
        coordinator.goToConfirmation(
            ConfirmationInfo(
                name: name,
                email: email,
                dateOfBirth: dateOfBirth
            )
        )
    }
}

private extension RegisterViewModel {
    func onSetNewDateOfBirth() {
        validateDateOfBirth()
    }
    
    func validateFields() {
        validateName()
        validateEmail()
        validateDateOfBirth()
    }
    
    func validateNameIfNotEmpty() {
        nameError = nil
        guard !name.isEmpty else {
            return
        }
        validateName()
    }
    
    func validateEmailIfNotEmpty() {
        emailError = nil
        guard !email.isEmpty else {
            return
        }
        validateEmail()
    }
    
    func validateName() {
        nameError = nil
        do {
            try nameValidator.validate(name)
        } catch ValidationError.invalidName(let message) {
            nameError = message
        } catch {}
    }
    
    func validateEmail() {
        emailError = nil
        do {
            try emailValidator.validate(email)
        } catch ValidationError.invalidEmail(let message) {
            emailError = message
        } catch {}
    }
    
    func validateDateOfBirth() {
        dateOfBirthError = nil
        do {
            try dateOfBirthValidator.validate(dateOfBirth)
        } catch ValidationError.invalidDateOfBirth(let message) {
            dateOfBirthError = message
        } catch {}
    }
}
