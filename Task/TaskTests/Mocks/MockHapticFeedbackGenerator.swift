//
//  MockHapticFeedbackGenerator.swift
//  TaskTests
//
//  Created by Jan Gulkowski on 31/08/2023.
//

import Foundation

class MockHapticFeedbackGenerator: HapticFeedbackGenerating {
    var generatedSuccessfulSound = false
    
    func generateSuccessSound() {
        generatedSuccessfulSound = true
    }
}
