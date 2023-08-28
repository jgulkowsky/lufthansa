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
    @Published var dateOfBirth: Date = Date(timeIntervalSince1970: 946724400) // should be 1 Jan 2000 12:00 polish time
    
    @Published var error: String? = nil
    var registerButtonEnabled: Bool = false
    
    private var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func onRegisterButtonTapped() {
        print("onRegisterButtonTapped")
        
        // todo: add validation for fields - separate file probably
        
        coordinator.goToConfirmation(
            ConfirmationInfo(
                name: name,
                email: email,
                dateOfBirth: dateOfBirth
            )
        )
    }
}
