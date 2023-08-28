//
//  RegisterView.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import SwiftUI

// todo: background for the DatePicker looks like it doesn't use our preferedColorScheme
// todo: DatePicker dateFormat is ugly
// todo: we need to add @FocusState
// todo: we need to add locking register button and showing errors
// todo: we need to add validators
// todo: we need to add tests for these

struct RegisterView: View {
    @ObservedObject var viewModel: RegisterViewModel

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Name:")
                    Spacer()
                        .frame(width: 20)
                    TextField("John Smith", text: $viewModel.name)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("E-mail:")
                    Spacer()
                        .frame(width: 20)
                    TextField("john.smith@go.co", text: $viewModel.email)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.emailAddress)
                }
                
                DatePicker(
                    selection: $viewModel.dateOfBirth,
                    in: ...Date.now,
                    displayedComponents: .date
                ) {
                    Text("Date of birth:")
                }
                
                Spacer()
                
                Button {
                    viewModel.onRegisterButtonTapped()
                } label: {
                    Text("Register")
                        .font(.system(size: 18, weight: .semibold))
                        .padding(.horizontal)
                }
                .padding()
                .foregroundColor(.white)
                .background(.green)
                .clipShape(Capsule())
            }
            .padding()
            .navigationTitle("Register")
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
