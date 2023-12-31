import Foundation
import SwiftUI

struct Conversation: Identifiable {
    var id = UUID()
    var questionText: String
    var answerText: String
}
