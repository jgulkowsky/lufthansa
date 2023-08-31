//
//  RegisterView.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import SwiftUI

// todo: verify if haptic works on physical device and add haptic for failed action
// todo: highlight the field which has error
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
                    onEditingStarted: viewModel.onStartedEditingName,
                    onEditingFinished: viewModel.onFinishedEditingName
                )
                .focused($focusedField, equals: .name)
                .onSubmit { focusedField = .email }
                
                TextFieldView(
                    label: "E-mail:",
                    placeholder: "john.smith@go.co",
                    text: $viewModel.email,
                    hasError: viewModel.emailError != nil,
                    onEditingStarted: viewModel.onStartedEditingEmail,
                    onEditingFinished: viewModel.onFinishedEditingEmail
                )
                .focused($focusedField, equals: .email)
                .onSubmit { focusedField = nil }
                
                DatePicker(
                    selection: $viewModel.dateOfBirth,
                    in: ...Date.now,
                    displayedComponents: .date
                ) {
                    Text("Date of birth:")
                }.onTapGesture {
                    focusedField = nil // we need to loose focus from previously tapped textfield
                }
                .foregroundColor(viewModel.dateOfBirthError != nil ? .red : .black)
                
                if let error = viewModel.latestError {
                    ErrorView(error: error)
                }
                
                Spacer()
                
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
