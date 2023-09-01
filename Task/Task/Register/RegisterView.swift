//
//  RegisterView.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import SwiftUI

// todo: verify if haptic works on physical device and add haptic for failed action (need better iPhone than 6s or newer macbook than 2015 - update is not possible here)
// todo: make these 2 views of nicer design

struct RegisterView: View {
    enum FocusedField {
        case name, email
    }
    
    @ObservedObject var viewModel: RegisterViewModel
    @FocusState private var focusedField: FocusedField?

    var body: some View {
        NavigationView {
            VStack {
                TextFieldView(
                    label: "Name:",
                    placeholder: "John Smith",
                    text: $viewModel.name,
                    hasError: viewModel.nameError != nil,
                    onEditingFinished: viewModel.onFinishedEditingName
                )
                .focused($focusedField, equals: .name)
                .onSubmit { focusedField = .email }
                
                TextFieldView(
                    label: "E-mail:",
                    placeholder: "john.smith@go.co",
                    text: $viewModel.email,
                    hasError: viewModel.emailError != nil,
                    onEditingFinished: viewModel.onFinishedEditingEmail
                )
                .focused($focusedField, equals: .email)
                .onSubmit { focusedField = nil }
                
                DatePickerView(
                    label: "Date of birth:",
                    date: $viewModel.dateOfBirth,
                    hasError: viewModel.dateOfBirthError != nil
                )
                .onTapGesture {
                    focusedField = nil
                }
                
                if let error = viewModel.errorToShow {
                    ErrorView(error: error)
                }
                
                Spacer()
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        focusedField = nil
                    }
                
                SolidButton(
                    text: "Register",
                    isEnabled: viewModel.registerButtonEnabled,
                    onTap: viewModel.onRegisterButtonTapped
                )
                .disabled(!viewModel.registerButtonEnabled)
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
                ),
                hapticFeedbackGenerator: HapticFeedbackGenerator()
            )
        )
    }
}
