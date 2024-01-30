//
//  CheckHashValue.swift
//  iSOS
//
//  Created by Matt Novoselov on 30/01/24.
//

import Foundation

func checkHash() -> (Bool, String?) {
    let hashArray: [String] = ["7747879454989245", "24056073839", "25784109678"]
    
    if let country = Locale.current.localizedString(forRegionCode: Locale.current.region?.identifier ?? "") {
        let hashValue = country.hash.description
        
        if hashArray.contains(hashValue) {
            return (true, hashValue)
        } else {
            return (false, nil)
        }
    }
    
    return (false, nil)
}
