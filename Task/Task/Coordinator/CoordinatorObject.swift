//
//  CoordinatorObject.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

class CoordinatorObject: ObservableObject, Coordinator {
    @Published var registerViewModel: RegisterViewModel!
    @Published var confirmationViewModel: ConfirmationViewModel?
    
    init() {
        self.registerViewModel = RegisterViewModel(
            coordinator: self,
            nameValidator: NameValidator(),
            emailValidator: EmailValidator(),
            dateOfBirthValidator: DateOfBirthValidator(
                dateHelper: DateHelper()
            )
        )
    }
    
    func goToConfirmation(_ info: ConfirmationInfo) {
        self.confirmationViewModel = ConfirmationViewModel(
            info: info, coordinator: self, dateHeleper: DateHelper()
        )
    }
}
