//
//  RegisterView.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import SwiftUI

// todo: verify if haptic works on physical device and add haptic for failed action
// todo: it would be nice to add showing errors as soon as user finish typing in a given field - but then you need to validate only given field then and to put it to the error - solution here would be to validate all the fields and then this field only - if this field only is ok still other fields can have errors
// todo: it would be nice to highlight the field which has problem - for this you need 3 errors
// todo: it would be nice to have views split into smaller structs - like MyTextField MyButton MyError (or better names)
// todo: we need different kind of validation - because we shouldn't show error when field is empty when finished typing but we should show error when field is empty on buttonSubmit - or we can deal with it more easily - we just don't let register button to be enabled if any of the fields is empty or we have error (when textfield is opened and filled and it has error - error variable can be not set yet - so validate once again)
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
                ),
                hapticFeedbackGenerator: HapticFeedbackGenerator()
            )
        )
    }
}
