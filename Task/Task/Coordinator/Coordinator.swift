//
//  Coordinator.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import Foundation

protocol Coordinator: AnyObject {
    func goToConfirmation(_ info: ConfirmationInfo)
}
