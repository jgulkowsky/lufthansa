//
//  CoordinatorView.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import SwiftUI

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
