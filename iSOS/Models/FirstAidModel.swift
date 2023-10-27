import Foundation
import SwiftUI

struct FirstAidModel: Identifiable {
    var id = UUID()
    var title: String
    var iconName: String
}

func getFirstAidRows(for firstAidName: String) -> [String] {
    guard let path = Bundle.main.path(forResource: "firstAid", ofType: "csv") else {
        return ["Error: Couldn't find the CSV file"]
    }
    
    do {
        let csvData = try String(contentsOfFile: path)
        let rows = csvData.components(separatedBy: "\n")
        
        var results: [String] = []
        
        for row in rows {
            let columns = row.components(separatedBy: ";")
            if columns.first == firstAidName {
                results = row.split(separator: ";").map(String.init)
                break
            }
        }
        
        results = results.map { $0.replacingOccurrences(of: "\r", with: "") }
        results = results.filter { !$0.isEmpty }
        if !results.isEmpty {
            results.removeFirst()
        }
        return results
        
    } catch {
        return ["Error: Couldn't read the CSV file"]
    }
}
