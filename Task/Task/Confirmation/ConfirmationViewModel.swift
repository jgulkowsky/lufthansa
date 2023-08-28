//
//  ConfirmationViewModel.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

class ConfirmationViewModel: ObservableObject {
    @Published var name: String
    @Published var email: String
    @Published var dateOfBirth: String
    
    private var coordinator: Coordinator
    
    init(info: ConfirmationInfo,
         coordinator: Coordinator,
         dateHeleper: DateHelping
    ) {
        self.coordinator = coordinator

        self.name = info.name
        self.email = info.email
        self.dateOfBirth = dateHeleper.dateToString(info.dateOfBirth, withFormat: "dd MMM yyyy")
    }
}
