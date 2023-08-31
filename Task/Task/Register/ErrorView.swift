//
//  ErrorView.swift
//  Task
//
//  Created by Jan Gulkowski on 31/08/2023.
//

import SwiftUI

struct ErrorView: View {
    var error: String
    
    var body: some View {
        Text(error)
            .padding(.top, 5)
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(
            error: "ERROR!"
        )
    }
}
