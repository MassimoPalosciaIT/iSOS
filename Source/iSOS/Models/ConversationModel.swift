//
//
//
//
//
//

import Foundation

// Phrases Model for PhrasesView
public struct Phrases: Identifiable {
    public var id = UUID()
    
    // Leading text blob
    var questionText: String
    
    // Trailing text blob
    var answerText: String
}
