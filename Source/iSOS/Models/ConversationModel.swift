//
//
//
//
//
//

import Foundation

// Phrases Model for PhrasesView
struct Phrases: Identifiable {
    var id = UUID()
    
    // Leading text blob
    var questionText: String
    
    // Trailing text blob
    var answerText: String
}
