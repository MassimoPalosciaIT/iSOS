//
//
//
//
//
//

import Foundation

func translateCoordinates(coordinate: String) -> String {
    let numberWords = ["zero", "uno", "due", "tre", "quattro", "cinque", "sei", "sette", "otto", "nove"]
    let coordinateCharacters = Array(coordinate)
    
    var translatedWords: [String] = []
    
    for character in coordinateCharacters {
        if let number = Int(String(character)) {
            translatedWords.append(numberWords[number])
        }
    }
    
    return translatedWords.joined(separator: ", ")
}
