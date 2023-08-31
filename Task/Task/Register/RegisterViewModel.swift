//
//  RegisterViewModel.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var dateOfBirth: Date = Date(timeIntervalSince1970: 946724400) {
        didSet {
            onSetNewDateOfBirth()
        }
    }
    
    @Published var latestError: String? = nil // todo: as we have all these private errors now public maybe we don't need latestError - especially not everything works with it?
    @Published var nameError: String? = nil {
        didSet {
            if nameError != nil {
                latestError = nameError
            } else if emailError == nil && dateOfBirthError == nil {
                latestError = nil
            }
        }
    }
    @Published var emailError: String? = nil {
        didSet {
            if emailError != nil {
                latestError = emailError
            } else if nameError == nil && dateOfBirthError == nil {
                latestError = nil
            }
        }
    }
    @Published var dateOfBirthError: String? = nil {
        didSet {
            if dateOfBirthError != nil {
                latestError = dateOfBirthError
            } else if nameError == nil && emailError == nil {
                latestError = nil
            }
        }
    }
    
    var registerButtonEnabled: Bool {
        !name.isEmpty && !email.isEmpty && latestError == nil
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
    
    func onStartedEditingName() {
        nameError = nil
    }
    
    func onStartedEditingEmail() {
        emailError = nil
    }
    
    func onFinishedEditingName() {
        nameError = nil
        guard !name.isEmpty else {
            return
        }
        
        do {
            try nameValidator.validate(name)
        } catch ValidationError.invalidName(let message) {
            nameError = message
        } catch {}
    }
    
    func onFinishedEditingEmail() {
        emailError = nil
        guard !email.isEmpty else {
            return
        }
        
        do {
            try emailValidator.validate(email)
        } catch ValidationError.invalidEmail(let message) {
            emailError = message
        } catch {}
    }
    
    func onRegisterButtonTapped() {
        validateFields()
        
        guard latestError == nil else {
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
    func validateFields() {
        nameError = nil
        emailError = nil
        dateOfBirthError = nil
        latestError = nil
        
        do {
            try nameValidator.validate(name)
            try emailValidator.validate(email)
            try dateOfBirthValidator.validate(dateOfBirth)
        } catch ValidationError.invalidName(let message) {
            nameError = message
        } catch ValidationError.invalidEmail(let message) {
            emailError = message
        } catch ValidationError.invalidDateOfBirth(let message) {
            dateOfBirthError = message
        } catch {}
    }
    
    func onSetNewDateOfBirth() {
        dateOfBirthError = nil
        
        do {
            try dateOfBirthValidator.validate(dateOfBirth)
        } catch ValidationError.invalidDateOfBirth(let message) {
            dateOfBirthError = message
        } catch {}
    }
}
