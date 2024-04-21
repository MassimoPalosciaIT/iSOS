//
//
//
//
//
//

import Foundation

// Function that translates a sequence of coordinates to the according Italian translation
func translateCoordinates(coordinate: String) -> String {
    // Array of Italian words from 0 to 9
    let numberWords = ["zero", "uno", "due", "tre", "quattro", "cinque", "sei", "sette", "otto", "nove"]
    let coordinateCharacters = Array(coordinate)
    
    var translatedWords: [String] = []
    
    // Replace each number with word
    for character in coordinateCharacters {
        if let number = Int(String(character)) {
            translatedWords.append(numberWords[number])
        }
    }
    
    // Return string separated by comma
    return translatedWords.joined(separator: ", ")
}
