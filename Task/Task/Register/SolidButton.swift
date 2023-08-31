//
//  SolidButton.swift
//  Task
//
//  Created by Jan Gulkowski on 31/08/2023.
//

import SwiftUI

struct SolidButton: View {
    var text: String
    var isEnabled: Bool
    var onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            Text(text)
                .font(.system(size: 18, weight: .semibold))
                .padding(.horizontal)
        }
        .padding()
        .foregroundColor(.white)
        .background(isEnabled ? .green : .gray)
        .clipShape(Capsule())
    }
}

struct SolidButton_Previews: PreviewProvider {
    static var previews: some View {
        SolidButton(
            text: "Button",
            isEnabled: true,
            onTap: { print("onTap") }
        )
    }
}
