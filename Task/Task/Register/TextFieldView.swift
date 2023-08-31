//
//  TextFieldView.swift
//  Task
//
//  Created by Jan Gulkowski on 31/08/2023.
//

import SwiftUI

struct TextFieldView: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    
    var onEditingStarted: (() -> Void)? = nil
    var onEditingFinished: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
                .frame(width: 20)
            TextField(
                placeholder,
                text: $text,
                onEditingChanged: { hasFocus in
                    if hasFocus {
                        onEditingStarted?()
                    } else {
                        onEditingFinished?()
                    }
                }
            )
            .multilineTextAlignment(.trailing)
            .autocorrectionDisabled()
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(
            label: "Name:",
            placeholder: "John Wick",
            text: .constant("Jaś Fasola"),
            onEditingStarted: { print("onEditingStarted") },
            onEditingFinished: { print("onEditingFinished") }
        )
    }
}
