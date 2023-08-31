//
//  HapticFeedbackGenerator.swift
//  Task
//
//  Created by Jan Gulkowski on 31/08/2023.
//

import SwiftUI

struct HapticFeedbackGenerator: HapticFeedbackGenerating {
    func generateSuccessSound() {
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
        impactMed.impactOccurred()
    }
}
