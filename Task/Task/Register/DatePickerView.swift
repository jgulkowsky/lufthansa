//
//  DatePickerView.swift
//  Task
//
//  Created by Jan Gulkowski on 31/08/2023.
//

import SwiftUI

struct DatePickerView: View {
    var label: String
    @Binding var date: Date
    var hasError: Bool
    
    var body: some View {
        DatePicker(
            selection: $date,
            in: ...Date.now,
            displayedComponents: .date
        ) {
            Text(label)
        }
        .foregroundColor(hasError ? .red : .black)
        .accentColor(hasError ? .red : .blue)
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(
            label: "Date:",
            date: .constant(Date.now),
            hasError: true
        )
    }
}
