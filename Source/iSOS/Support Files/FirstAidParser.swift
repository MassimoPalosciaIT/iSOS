//
//
//
//
//
//

import Foundation

struct FirstAidModel: Identifiable {
    var id = UUID()
    var title: String
    var iconName: String
}

func getFirstAidRows(for firstAidName: String) -> [String] {
    guard let csvPath = Bundle.main.path(forResource: "firstAid", ofType: "csv"),
          let csvContent = try? String(contentsOfFile: csvPath) else {
        return ["Error: Couldn't find the CSV file"]
    }

    let lines = csvContent.components(separatedBy: "\n")

    for line in lines{
        var columns = line.split(separator: ";", omittingEmptySubsequences: false)
                          .map(String.init)
        
        // Remove any instances of "\r" and trim each column.
        columns = columns.map { $0.replacingOccurrences(of: "\r", with: "").trimmingCharacters(in: .whitespacesAndNewlines) }
        
        // Filter out empty strings after trimming.
        var filteredColumns = columns.filter { !$0.isEmpty }
        
        if let firstColumn = filteredColumns.first, firstColumn == firstAidName {
            filteredColumns.removeFirst() // Remove the first element, which is the firstAidName
            return filteredColumns
        }
    }

    return ["Error: Couldn't find columns for this type of first aid"]
}
