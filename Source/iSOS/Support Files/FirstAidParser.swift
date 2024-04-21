//
//
//
//
//
//

import Foundation

// Function that parses and returns first aid tips from the .csv file
func getFirstAidRows(for firstAidName: String) -> [String] {
    // Validate path to the .scv file
    guard let csvPath = Bundle.main.path(forResource: "firstAid", ofType: "csv"),
          let csvContent = try? String(contentsOfFile: csvPath) else {
        return ["Error: Couldn't find the CSV file"]
    }
    
    // Get lines from .scv, separating them by \n
    let lines = csvContent.components(separatedBy: "\n")
    
    // For each line in .scv, get columns
    for line in lines{
        var columns = line.split(separator: ";", omittingEmptySubsequences: false)
            .map(String.init)
        
        // Remove any instances of "\r" and trim each column.
        columns = columns.map { $0.replacingOccurrences(of: "\r", with: "").trimmingCharacters(in: .whitespacesAndNewlines) }
        
        // Filter out empty strings after trimming.
        var filteredColumns = columns.filter { !$0.isEmpty }
        
        if let firstColumn = filteredColumns.first, firstColumn == firstAidName {
            // Remove the first element, which is the firstAidName
            filteredColumns.removeFirst()
            return filteredColumns
        }
    }
    
    return ["Error: Couldn't find columns for this type of first aid"]
}
