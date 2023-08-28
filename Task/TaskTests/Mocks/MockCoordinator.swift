//
//  MockCoordinator.swift
//  TaskTests
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

class MockCoordinator: Coordinator {
    var wentToConfirmation = false
    
    func goToConfirmation(_ info: ConfirmationInfo) {
        wentToConfirmation = true
    }
}
