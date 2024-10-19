//
//
//
//
//
//

import SwiftUI

// Types of emergencies
public enum EmergencyType {
    case police
    case medicalHelp
    case fireDepartment
}

// Function to start a phone call, given a defined phone number
private func startCall(to number: String) {
    guard let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) else {
        print("Error: Unable to initiate call.")
        return
    }
    
    UIApplication.shared.open(url)
}

// Function to get emergency number for particular agency (emergency type), based on the country
public func getEmergencyNumber(for country: String, emergencyType: EmergencyType) -> String {
    // Validate path to .csv file
    guard let csvPath = Bundle.main.path(forResource: "emergencyNumbers", ofType: "csv"),
          let csvContent = try? String(contentsOfFile: csvPath) else {
        return "File not found"
    }
    
    // Extract lines from the .csv file
    let lines = csvContent.components(separatedBy: .newlines)
    
    // Extract columns for each line
    for line in lines {
        let columns = line.split(separator: ";")
        guard columns.count >= 4 else { continue }
        
        if columns[0] == country {
            switch emergencyType {
            case .police:
                return String(columns[1])
            case .medicalHelp:
                return String(columns[2])
            case .fireDepartment:
                return String(columns[3])
            }
        }
    }
    
    print("Error: Unable to get emergency number. Returning a standard number.")
    
    return "+112"
}

func startCall(to emergencyType: EmergencyType, locationModel: LocationModel){
    
    // Get current country emergency number based on the location
    let countryEmergencyNumber: String = getEmergencyNumber(for: locationModel.getCountry(), emergencyType: emergencyType)
    
    // Start phone call
    startCall(to: countryEmergencyNumber)
}
