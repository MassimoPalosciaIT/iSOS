import SwiftUI
import CoreHaptics

func mediumHaptic() {
    let impactHeavy = UIImpactFeedbackGenerator(style: .medium)
    impactHeavy.impactOccurred()
}

func softHaptic() {
    let impactHeavy = UIImpactFeedbackGenerator(style: .soft)
    impactHeavy.impactOccurred()
}
