//
//  RegisterView.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import SwiftUI

struct RegisterView: View {
    private var viewModel: RegisterViewModel
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Register")
            Text("Bla")
            Text("Bla")
            Text("Bla")
            Button {
                viewModel.onRegisterButtonTapped()
            } label: {
                Text("Register")
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(
            viewModel: RegisterViewModel(
                coordinator: CoordinatorObject()
            )
        )
    }
}
