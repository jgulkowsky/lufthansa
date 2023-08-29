//
//  ConfirmationView.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import SwiftUI

struct ConfirmationView: View {
    @ObservedObject var viewModel: ConfirmationViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 100)
    
                Text("Thank You")
                    .font(.system(size: 22, weight: .semibold))
    
                Text("For registering with")
                    .padding(.top, 2)
                Text("the following details:")
                
                Text("\u{2022} Name: \(viewModel.name)")
                    .padding(.top, 5)
                    .font(.system(size: 17, weight: .medium))
                
                Text("\u{2022} E-mail: \(viewModel.email)")
                    .padding(.top, 2)
                    .font(.system(size: 17, weight: .medium))
                
                Text("\u{2022} Date of birth: \(viewModel.dateOfBirth)")
                    .padding(.top, 2)
                    .font(.system(size: 17, weight: .medium))
                
                Spacer()
            }
            .padding()
            .navigationTitle("Confirmation")
        }
        .font(.system(size: 18))
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static private var info: ConfirmationInfo {
        let dateString = "25/04/1992"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let date = dateFormatter.date(from: dateString)!
        let info = ConfirmationInfo(
            name: "Jan G",
            email: "jg@jg.co",
            dateOfBirth: date
        )
        return info
    }
    
    static var previews: some View {
        ConfirmationView(
            viewModel: ConfirmationViewModel(
                info: info,
                coordinator: CoordinatorObject(),
                dateHelper: DateHelper()
            )
        )
    }
}
