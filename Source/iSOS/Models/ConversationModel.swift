//
//
//
//
//
//

import Foundation

// Conversation Model for Conversation View
struct Conversation: Identifiable {
    var id = UUID()
    
    // Leading text blob
    var questionText: String
    
    // Trailing text blob
    var answerText: String
}
