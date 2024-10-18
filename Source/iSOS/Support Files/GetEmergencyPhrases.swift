//
//  EmergencyPhrasesModel.swift
//  Yaha
//
//  Created by Matt Novoselov on 18/10/24.
//


import SwiftUI

public func getEmergencyPhrases(emergencyType: EmergencyType, address: String?, formattedCoordinates: String?) -> [Phrases] {
    
    // Phrases for Police
    let policePhrases: [Phrases] = [
        Phrases(questionText: "Hello, I need to report an emergency.", answerText: "Salve, mi serve di denunciare un'emergenza."),
        Phrases(questionText: "\(address ?? "") \((address != nil) ? "\n\n" : "")My coordinates are: \(formattedCoordinates ?? "")", answerText: "\(address ?? "") \((address != nil) ? "\n\n" : "")Le mie coordinate sono: \(formattedCoordinates ?? "")\n\n(\(translateCoordinates(coordinate: formattedCoordinates ?? "")))"),
        Phrases(questionText: "There is a [robbery/assault/accident/etc.] occurring.", answerText: "Si sta verificando una [rapina/aggressione/incidente/ecc.]."),
        Phrases(questionText: "There are [number] of victims/injured people.", answerText: "Ci sono [numero] di vittime/feriti."),
        Phrases(questionText: "Please send help immediately.", answerText: "Vi prego di inviare immediatamente i soccorsi."),
        Phrases(questionText: "My name is [your name].", answerText: "Il mio nome è [il vostro nome].")
    ]
    
    // Phrases for Fire Department
    let fireDepartmentPhrases: [Phrases] = [
        Phrases(questionText: "Hello, I need to report a fire emergency.", answerText: "Salve, devo denunciare un'emergenza incendio."),
        Phrases(questionText: "\(address ?? "") \((address != nil) ? "\n\n" : "")My coordinates are: \(formattedCoordinates ?? "")", answerText: "\(address ?? "") \((address != nil) ? "\n\n" : "")Le mie coordinate sono: \(formattedCoordinates ?? "")\n\n(\(translateCoordinates(coordinate: formattedCoordinates ?? "")))"),
        Phrases(questionText: "The fire is [large/small/spreading rapidly/etc.].", answerText: "L'incendio è [grande/piccolo/si sta espandendo rapidamente/ecc.]."),
        Phrases(questionText: "Please send help immediately; it's urgent.", answerText: "Vi prego di inviare immediatamente i soccorsi; è urgente."),
        Phrases(questionText: "My name is [your name].", answerText: "Il mio nome è [il vostro nome].")
    ]
    
    // Phrases for Medical Help
    let medicalHelpPhrases: [Phrases] = [
        Phrases(questionText: "Hello, I need medical assistance immediately.", answerText: "Salve, mi serve assistenza medica immediatamente."),
        Phrases(questionText: "\(address ?? "") \((address != nil) ? "\n\n" : "")My coordinates are: \(formattedCoordinates ?? "")", answerText: "\(address ?? "") \((address != nil) ? "\n\n" : "")Le mie coordinate sono: \(formattedCoordinates ?? "")\n\n(\(translateCoordinates(coordinate: formattedCoordinates ?? "")))"),
        Phrases(questionText: "Someone is injured/ill.", answerText: "Qualcuno è ferito/malato."),
        Phrases(questionText: "There has been an accident.", answerText: "C'è stato un incidente."),
        Phrases(questionText: "The person is [conscious/unconscious/breathing/not breathing].", answerText: "La persona è [cosciente/incosciente/respira/non respira]."),
        Phrases(questionText: "Please send help quickly; it's urgent.", answerText: "Vi prego di inviare rapidamente i soccorsi, è urgente."),
        Phrases(questionText: "My name is [your name].", answerText: "Il mio nome è [il vostro nome].")
    ]
    
    // Return appropriate phrases based on the emergency type
    switch emergencyType {
    case .police:
        return policePhrases
    case .medicalHelp:
        return medicalHelpPhrases
    case .fireDepartment:
        return fireDepartmentPhrases
    }
}
