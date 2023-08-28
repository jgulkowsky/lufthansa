//
//  Coordinator.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import SwiftUI

protocol Coordinator {
    func goToConfirmation(_ info: ConfirmationInfo)
}

struct ConfirmationInfo {
    var name: String
    var email: String
    var dateOfBirth: Date
}

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

class ConfirmationViewModel: ObservableObject {
    @Published var info: ConfirmationInfo
    
    private var coordinator: Coordinator
    
    init(info: ConfirmationInfo, coordinator: Coordinator) {
        self.info = info
        self.coordinator = coordinator
    }
}

class CoordinatorObject: ObservableObject, Coordinator {
    @Published var registerViewModel: RegisterViewModel!
    @Published var confirmationViewModel: ConfirmationViewModel?
    
    init() {
        self.registerViewModel = RegisterViewModel(coordinator: self)
    }
    
    func goToConfirmation(_ info: ConfirmationInfo) {
        self.confirmationViewModel = ConfirmationViewModel(
            info: info, coordinator: self
        )
    }
}

struct CoordinatorView: View {
    @ObservedObject var object: CoordinatorObject
    
    var body: some View {
        if let confirmationViewModel = self.object.confirmationViewModel {
            ConfirmationView(viewModel: confirmationViewModel)
        } else {
            RegisterView(viewModel: self.object.registerViewModel)
        }
    }
}

struct CoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatorView(object: CoordinatorObject())
    }
}
