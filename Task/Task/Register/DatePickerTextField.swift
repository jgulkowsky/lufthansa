//
//  DatePickerTextField.swift
//  Task
//
//  Created by Jan Gulkowski on 04/09/2023.
//

import SwiftUI

struct DatePickerTextField: UIViewRepresentable {
    @Binding var date: Date?
    let placeholder: String
    @Binding var color: Color
    
    private let dateHelper: DateHelping
    
    init(date: Binding<Date?>,
         placeholder: String,
         color: Binding<Color>,
         dateHelper: DateHelping
    ) {
        self._date = date
        self.placeholder = placeholder
        self._color = color
        self.dateHelper = dateHelper
    }
    
    func makeUIView(context: Context) -> DatePickerUITextField {
        let uiView = DatePickerUITextField(
            date: $date,
            color: Binding(
                get: {
                    UIColor(color)
                },
                set: { _ in }
            ),
            frame: .zero
        )
        uiView.placeholder = placeholder
        if let date = date {
            uiView.text = getDateString(from: date)
        }
        return uiView
    }
    
    func updateUIView(_ uiView: DatePickerUITextField, context: Context) {
        if let date = date {
            uiView.text = getDateString(from: date)
        }
    }
}

private extension DatePickerTextField {
    func getDateString(from date: Date) -> String {
        dateHelper.setDateFormat("dd MMM yyyy")
        let dateString = dateHelper.dateToString(date)
        return dateString
    }
}

struct DatePickerTextField_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerTextField(
            date: .constant(nil),
            placeholder: "01 Jan 2020",
            color: .constant(.red),
            dateHelper: DateHelper()
        )
    }
}
