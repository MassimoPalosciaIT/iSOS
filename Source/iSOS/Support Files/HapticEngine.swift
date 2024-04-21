//
//
//
//
//
//

import SwiftUI
import CoreHaptics

// Medium haptic feedback
func mediumHaptic() {
    let impactHeavy = UIImpactFeedbackGenerator(style: .medium)
    impactHeavy.impactOccurred()
}

// Soft haptic feedback
func softHaptic() {
    let impactHeavy = UIImpactFeedbackGenerator(style: .soft)
    impactHeavy.impactOccurred()
}
