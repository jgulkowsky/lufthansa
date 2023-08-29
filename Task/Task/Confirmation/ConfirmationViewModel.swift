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
    
    private unowned var coordinator: Coordinator
    
    private static let dateFormat = "dd MMM yyyy"
    
    init(info: ConfirmationInfo,
         coordinator: Coordinator,
         dateHelper: DateHelping // todo: rename
    ) {
        self.coordinator = coordinator

        self.name = info.name
        self.email = info.email
        dateHelper.setDateFormat(ConfirmationViewModel.dateFormat)
        self.dateOfBirth = dateHelper.dateToString(info.dateOfBirth)
    }
}
