//
//
//
//
//
//

import Foundation
import SwiftUI

struct CallModel{
    func startCall(to number: String) {
        guard let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) else {
            print("Error: Unable to initiate call.")
            return
        }
        
        UIApplication.shared.open(url)
    }
}

enum EmergencyType {
    case police
    case medicalHelp
    case fireDepartment
}

func getEmergencyNumber(for country: String, emergencyType: EmergencyType) -> String {
    guard let csvPath = Bundle.main.path(forResource: "emergencyNumbers", ofType: "csv"),
          let csvContent = try? String(contentsOfFile: csvPath) else {
        return "File not found"
    }

    let lines = csvContent.components(separatedBy: .newlines)
    
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

    return "+112"
}

func testTap(){
    print("Test tap")
}
