//
//  DatePickerView.swift
//  Task
//
//  Created by Jan Gulkowski on 31/08/2023.
//

import SwiftUI

struct DatePickerView: View {
    var dateHelper: DateHelping
    var label: String
    @Binding var date: Date?
    @Binding var error: String?
    
    private var hasError: Bool {
        return error != nil
    }
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(hasError ? .red : .black)
            Spacer()
                .frame(width: 20)
            DatePickerTextField(
                date: $date,
                placeholder: "01 Jan 2020",
                color: Binding(
                    get: {
                        hasError ? .red : .black
                    },
                    set: { _ in }
                ),
                dateHelper: dateHelper
            )
            .frame(height: 0)
        }
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(
            dateHelper: DateHelper(),
            label: "Date:",
            date: .constant(Date.now),
            error: .constant("Some error")
        )
    }
}
