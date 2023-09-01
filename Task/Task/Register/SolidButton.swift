//
//  SolidButton.swift
//  Task
//
//  Created by Jan Gulkowski on 31/08/2023.
//

import SwiftUI

struct SolidButton: View {
    var text: String
    var enabled: Bool
    var color: Color
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
        .background(color)
        .clipShape(Capsule())
        .disabled(!enabled)
    }
}

struct SolidButton_Previews: PreviewProvider {
    static var previews: some View {
        SolidButton(
            text: "Button",
            enabled: true,
            color: .blue,
            onTap: { print("onTap") }
        )
    }
}
