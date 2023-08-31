//
//  RegisterView.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import SwiftUI

// todo: verify if haptic works on physical device and add haptic for failed action
// todo: highlight the field which has error
// todo: it would be nice to have views split into smaller structs - like MyTextField MyButton MyError (or better names)
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
                HStack {
                    Text("Name:")
                    Spacer()
                        .frame(width: 20)
                    TextField(
                        "John Smith",
                        text: $viewModel.name,
                        onEditingChanged: { hasFocus in
                            if hasFocus {
                                viewModel.onStartedEditingName()
                            } else {
                                viewModel.onFinishedEditingName()
                            }
                        }
                    )
                    .multilineTextAlignment(.trailing)
                    .autocorrectionDisabled()
                    .focused($focusedField, equals: .name)
                    .onSubmit {
                        focusedField = .email
                    }
                }
                
                HStack {
                    Text("E-mail:")
                    Spacer()
                        .frame(width: 20)
                    TextField(
                        "john.smith@go.co",
                        text: $viewModel.email,
                        onEditingChanged: { hasFocus in
                            if hasFocus {
                                viewModel.onStartedEditingEmail()
                            } else {
                                viewModel.onFinishedEditingEmail()
                            }
                        }
                    )
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .focused($focusedField, equals: .email)
                    .onSubmit {
                        focusedField = nil
                    }
                }
                
                DatePicker(
                    selection: $viewModel.dateOfBirth,
                    in: ...Date.now,
                    displayedComponents: .date
                ) {
                    Text("Date of birth:")
                }.onTapGesture {
                    focusedField = nil // we need to loose focus from previously tapped textfield
                }
                
                if let error = viewModel.latestError {
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
                .disabled(!viewModel.registerButtonEnabled)
                .padding()
                .foregroundColor(.white)
                .background(viewModel.registerButtonEnabled ? .green : .gray)
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
                ),
                hapticFeedbackGenerator: HapticFeedbackGenerator()
            )
        )
    }
}
