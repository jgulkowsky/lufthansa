//
//  RegisterViewModel.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

class RegisterViewModel: ObservableObject {
    private var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func onRegisterButtonTapped() {
        print("onRegisterButtonTapped")
        
        let dateString = "25/04/1992"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        guard let date = dateFormatter.date(from: dateString) else {
            return
        }
        
        let info = ConfirmationInfo(
            name: "Jan G",
            email: "jg@jg.co",
            dateOfBirth: date
        )
        
        coordinator.goToConfirmation(info)
    }
}
