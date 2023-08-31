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
    @Published var dateOfBirth: Date = Date(timeIntervalSince1970: 946724400)
    
    @Published var error: String? = nil
    
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
    
    func onRegisterButtonTapped() {
        validateFields()
        
        guard error == nil else {
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
        error = nil
        
        do {
            try nameValidator.validate(name)
            try emailValidator.validate(email)
            try dateOfBirthValidator.validate(dateOfBirth)
        } catch ValidationError.invalidName(let message) {
            error = message
        } catch ValidationError.invalidEmail(let message) {
            error = message
        } catch ValidationError.invalidDateOfBirth(let message) {
            error = message
        } catch {}
    }
}
