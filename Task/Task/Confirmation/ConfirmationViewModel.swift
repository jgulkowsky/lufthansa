//
//  ConfirmationViewModel.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

class ConfirmationViewModel: ObservableObject {
    @Published var info: ConfirmationInfo
    
    private var coordinator: Coordinator
    
    init(info: ConfirmationInfo, coordinator: Coordinator) {
        self.info = info
        self.coordinator = coordinator
    }
}
