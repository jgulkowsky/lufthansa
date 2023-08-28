//
//  ConfirmationView.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import SwiftUI

struct ConfirmationView: View {
    private var viewModel: ConfirmationViewModel
    
    init(viewModel: ConfirmationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Confirmation")
            Text("name: \(viewModel.info.name)")
            Text("email: \(viewModel.info.email)")
            Text("date of birth: \(viewModel.info.dateOfBirth)")
        }
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
                coordinator: CoordinatorObject()
            )
        )
    }
}
