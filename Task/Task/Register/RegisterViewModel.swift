//
//  RegisterViewModel.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import SwiftUI
import CoreData

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
    
    @Published var dateOfBirth: Date? {
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
        !name.isEmpty && !email.isEmpty && errorToShow == nil && checkIfFieldsAreValid()
    }
    
    var registerButtonColor: Color {
        if errorToShow != nil {
            return .red
        }
        return registerButtonEnabled ? .green : .gray
    }
    
    private unowned var coordinator: Coordinator
    
    private var nameValidator: NameValidating
    private var emailValidator: EmailValidating
    private var dateOfBirthValidator: DateOfBirthValidating
    private var dataProvider: DataProviding
    private var hapticFeedbackGenerator: HapticFeedbackGenerating
    
    init(coordinator: Coordinator,
         nameValidator: NameValidating,
         emailValidator: EmailValidating,
         dateOfBirthValidator: DateOfBirthValidating,
         dataProvider: DataProviding,
         hapticFeedbackGenerator: HapticFeedbackGenerating) {
        self.coordinator = coordinator
        self.nameValidator = nameValidator
        self.emailValidator = emailValidator
        self.dateOfBirthValidator = dateOfBirthValidator
        self.dataProvider = dataProvider
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
        
        guard errorToShow == nil,
              let dateOfBirth = dateOfBirth else {
            return
        }
        
        do {
            let registeredUsers = try dataProvider.getRegisteredUsers()
            print("@jgu: \(registeredUsers.map { $0.email })")
            guard !registeredUsers.contains(where: { $0.email == email }) else {
                // todo: set proper error
                // todo: on the other hand this is rather dataProvider functinality no? it should rather return proper error and we should show it here
                print("@jgu: Trying to register with email that's already occupied")
                return
            }
        } catch {
            print("@jgu: Error on fetchRegisteredUsers")
            // todo: probably we should show it to the user
            return
        }

        do {
            try dataProvider.saveNewRegisteredUser(name, email, dateOfBirth)
        } catch {
            print("@jgu: Error on addUser")
            // todo: probably we should show it to the user
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
    
    func checkIfFieldsAreValid() -> Bool {
        do {
            try nameValidator.validate(name)
            try emailValidator.validate(email)
            try dateOfBirthValidator.validate(dateOfBirth)
        } catch {
            return false
        }
        
        return true
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
