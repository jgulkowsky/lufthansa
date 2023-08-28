//
//  RegisterView.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import SwiftUI

// todo: we need to add tests for these
// todo: the keyboard is sometimes visible on confirmation screen - we should close it on RegisterScreen with sth like this probably: func dismissKeyboard() { UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.endEditing(true) }

struct RegisterView: View {
    enum FocusedField {
        case name, email
    }
    
    @ObservedObject var viewModel: RegisterViewModel
    @FocusState private var focusedField: FocusedField?

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Name:")
                    Spacer()
                        .frame(width: 20)
                    TextField("John Smith", text: $viewModel.name)
                        .multilineTextAlignment(.trailing)
                        .autocorrectionDisabled()
                        .focused($focusedField, equals: .name)
                        .onSubmit { focusedField = .email }
                }
                
                HStack {
                    Text("E-mail:")
                    Spacer()
                        .frame(width: 20)
                    TextField("john.smith@go.co", text: $viewModel.email)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .focused($focusedField, equals: .email)
                        .onSubmit { focusedField = nil }
                }
                
                DatePicker(
                    selection: $viewModel.dateOfBirth,
                    in: ...Date.now,
                    displayedComponents: .date
                ) {
                    Text("Date of birth:")
                }
                
                if let error = viewModel.error {
                    Text(error)
                        .padding(.top, 5)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
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
                coordinator: CoordinatorObject(),
                nameValidator: NameValidator(),
                emailValidator: EmailValidator(),
                dateOfBirthValidator: DateOfBirthValidator(
                    dateHelper: DateHelper()
                )
            )
        )
    }
}
